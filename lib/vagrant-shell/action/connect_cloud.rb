require "log4r"

module VagrantPlugins
  module Shell
    module Action
      # This action connects to a Cloud, verifies credentials work
      class ConnectCloud
        def initialize(app, env)
          @app    = app
          @logger = Log4r::Logger.new("vagrant_shell::action::connect_aws")
        end

        def call(env)
          # Get the region we're going to booting up in
          region = env[:machine].provider_config.region

          # Get the configs
          region_config = env[:machine].provider_config.get_region_config(region)

          # Build the fog config
          fog_config = {
            :provider => :aws,
            :region   => region
          }
          fog_config[:aws_access_key_id] = region_config.access_key_id
          fog_config[:aws_secret_access_key] = region_config.secret_access_key
          fog_config[:aws_session_token] = region_config.session_token

          fog_config[:endpoint] = region_config.endpoint if region_config.endpoint
          fog_config[:version]  = region_config.version if region_config.version

          @logger.info("Connecting to Cloud...")
          JSON.load(%x{vagrant-shell connect-to-cloud})

          @app.call(env)
        end
      end
    end
  end
end
