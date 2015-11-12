require "vagrant"

module VagrantPlugins
  module Shell
    module Errors
      class VagrantCloudError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_shell.errors")
      end

      class InstanceReadyTimeout < VagrantCloudError
        error_key(:instance_ready_timeout)
      end

      class RsyncError < VagrantCloudError
        error_key(:rsync_error)
      end

      class MkdirError < VagrantCloudError
        error_key(:mkdir_error)
      end

      class TimeoutError < VagrantCloudError
        error_key(:timeout_error)
      end

      class NotFound < VagrantCloudError
        error_key(:notfound_error)
      end

      class Error < VagrantCloudError
        error_key(:generic_error)
      end
    end
  end
end
