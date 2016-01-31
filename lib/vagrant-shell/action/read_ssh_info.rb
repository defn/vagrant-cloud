require "log4r"

module VagrantPlugins
  module Shell
    module Action
      # This action reads the SSH info for the machine and puts it into the
      # `:machine_ssh_info` key in the environment.
      class ReadSSHInfo
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_shell::action::read_ssh_info")
        end

        def call(env)
          env[:machine_ssh_info] = read_ssh_info(env[:machine])

          @app.call(env)
        end

        def read_ssh_info(machine)
          return nil if machine.id.nil?

          # Find the machine
          server = JSON.load(%x{vagrant-shell get-instance '#{machine.id}'})
          if server.nil?
            # The machine can't be found
            @logger.info("Machine couldn't be found, assuming it got destroyed.")
            machine.id = nil
            return nil
          end

          host_value = host_value = server.send(:host_address)
          return { :host => host_value, :port => 22 }
        end
      end
    end
  end
end
