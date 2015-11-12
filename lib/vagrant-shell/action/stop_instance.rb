require "log4r"

module VagrantPlugins
  module Shell
    module Action
      # This stops the running instance.
      class StopInstance
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_shell::action::stop_instance")
        end

        def call(env)
          server = JSON.load(%x{vagrant-shell get-instance '#{env[:machine].id}'})

          if env[:machine].state.id == :stopped
            env[:ui].info(I18n.t("vagrant_shell.already_status", :status => env[:machine].state.id))
          else
            env[:ui].info(I18n.t("vagrant_shell.stopping"))
            server.stop(!!env[:force_halt])
          end

          @app.call(env)
        end
      end
    end
  end
end
