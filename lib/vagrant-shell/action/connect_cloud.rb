require "log4r"

module VagrantPlugins
  module Shell
    module Action
      # This action connects to a Cloud, verifies credentials work
      class ConnectCloud
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_shell::action::connect_cloud")
        end

        def call(env)
          # Get the region we're going to booting up in
          region = env[:machine].provider_config.region

          # Get the configs
          region_config = env[:machine].provider_config.get_region_config(region)

          # Build the cloud config
          cloud_config = {
            :provider => :shell,
            :region   => region
          }
          cloud_config[:cloud_access_key_id] = region_config.access_key_id
          cloud_config[:cloud_secret_access_key] = region_config.secret_access_key
          cloud_config[:cloud_session_token] = region_config.session_token

          cloud_config[:endpoint] = region_config.endpoint if region_config.endpoint
          cloud_config[:version]  = region_config.version if region_config.version

          @logger.info("Connecting to Cloud...")
          JSON.load(%x{vagrant-shell connect-to-cloud})

          @app.call(env)
        end
      end
    end
  end
end
