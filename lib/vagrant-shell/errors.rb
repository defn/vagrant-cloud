require "vagrant"

module VagrantPlugins
  module Shell
    module Errors
      class VagrantAWSError < Vagrant::Errors::VagrantError
        error_namespace("vagrant_aws.errors")
      end

      class InstanceReadyTimeout < VagrantAWSError
        error_key(:instance_ready_timeout)
      end

      class RsyncError < VagrantAWSError
        error_key(:rsync_error)
      end

      class MkdirError < VagrantAWSError
        error_key(:mkdir_error)
      end

      class TimeoutError < VagrantAWSError
        error_key(:timeout_error)
      end

      class NotFound < VagrantAWSError
        error_key(:notfound_error)
      end

      class Error < VagrantAWSError
        error_key(:generic_error)
      end
    end
  end
end
