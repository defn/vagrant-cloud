require "log4r"
require 'json'

require 'vagrant/util/retryable'

require 'vagrant-shell/util/timer'

module VagrantPlugins
  module Shell
    module Action
      # This runs the configured instance.
      class RunInstance
        include Vagrant::Util::Retryable

        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_shell::action::run_instance")
        end

        def call(env)
          # Initialize metrics if they haven't been
          env[:metrics] ||= {}

          # Get the region we're going to booting up in
          region = env[:machine].provider_config.region

          # Get the configs
          region_config         = env[:machine].provider_config.get_region_config(region)
          ami                   = region_config.ami
          availability_zone     = region_config.availability_zone
          instance_type         = region_config.instance_type
          env                   = region_config.env

          # Launch!
          env[:ui].info(I18n.t("vagrant_shell.launching_instance"))
          env[:ui].info(" -- Type: #{instance_type}")
          env[:ui].info(" -- AMI: #{ami}")
          env[:ui].info(" -- Region: #{region}")
          env[:ui].info(" -- Availability Zone: #{availability_zone}") if availability_zone

          options = {
            :availability_zone         => availability_zone,
            :flavor_id                 => instance_type,
            :image_id                  => ami,
            :env                       => env
          }

          server = JSON.load(%x{vagrant-shell create-instance #{options}})

          # Immediately save the ID since it is created at this point.
          env[:machine].id = server.id

          # Wait for the instance to be ready first
          env[:metrics]["instance_ready_time"] = Util::Timer.time do
            tries = region_config.instance_ready_timeout / 2

            env[:ui].info(I18n.t("vagrant_shell.waiting_for_ready"))
            begin
              retryable(:on => Shell::Errors::TimeoutError, :tries => tries) do
                # If we're interrupted don't worry about waiting
                next if env[:interrupted]

                # Wait for the server to be ready
                server.wait_for(2, region_config.instance_check_interval) { ready? }
              end
            rescue Shell::Errors::TimeoutError
              # Delete the instance
              terminate(env)

              # Notify the user
              raise Errors::InstanceReadyTimeout,
                timeout: region_config.instance_ready_timeout
            end
          end

          @logger.info("Time to instance ready: #{env[:metrics]["instance_ready_time"]}")

          if !env[:interrupted]
            env[:metrics]["instance_ssh_time"] = Util::Timer.time do
              # Wait for SSH to be ready.
              env[:ui].info(I18n.t("vagrant_shell.waiting_for_ssh"))
              network_ready_retries = 0
              network_ready_retries_max = 10
              while true
                # If we're interrupted then just back out
                break if env[:interrupted]
                # When an ec2 instance comes up, it's networking may not be ready
                # by the time we connect.
                begin
                  break if env[:machine].communicate.ready?
                rescue Exception => e
                  if network_ready_retries < network_ready_retries_max then
                    network_ready_retries += 1
                    @logger.warn(I18n.t("vagrant_shell.waiting_for_ssh, retrying"))
                  else
                    raise e
                  end
                end
                sleep 2
              end
            end

            @logger.info("Time for SSH ready: #{env[:metrics]["instance_ssh_time"]}")

            # Ready and booted!
            env[:ui].info(I18n.t("vagrant_shell.ready"))
          end

          # Terminate the instance if we were interrupted
          terminate(env) if env[:interrupted]

          @app.call(env)
        end

        def recover(env)
          return if env["vagrant.error"].is_a?(Vagrant::Errors::VagrantError)

          if env[:machine].provider.state.id != :not_created
            # Undo the import
            terminate(env)
          end
        end

        def terminate(env)
          destroy_env = env.dup
          destroy_env.delete(:interrupted)
          destroy_env[:config_validate] = false
          destroy_env[:force_confirm_destroy] = true
          env[:action_runner].run(Action.action_destroy, destroy_env)
        end
      end
    end
  end
end
