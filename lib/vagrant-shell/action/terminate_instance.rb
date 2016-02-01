require "log4r"

require 'vagrant-shell/util/shell'

module VagrantPlugins
  module Shell
    module Action
      # This terminates the running instance.
      class TerminateInstance
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_shell::action::terminate_instance")
        end

        def call(env)
          server         = JSON.load(%x{vagrant-shell get-instance '#{env[:machine].id}'})
          region         = env[:machine].provider_config.region
          region_config  = env[:machine].provider_config.get_region_config(region)

          # Destroy the server and remove the tracking ID
          env[:ui].info(I18n.t("vagrant_shell.terminating"))
          server.destroy
          env[:machine].id = nil

          @app.call(env)
        end
      end
    end
  end
end
