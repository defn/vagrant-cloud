This plugin provides a shell-script provider based on a gutted
vagrant-aws plugin.  Instead of calling to fog, it executes scripts.
Machine configuration are exported as enviroment variables before
calling the scripts.

# Getting Started
Install dependencies with bundler: `bundle _1.10.6_ install --path vendor/bundle`

Source `script/profile` to tune vagrant warnings and gem paths.  Only
tested on bash.

Runs tests: `bundle _1.10.6_ exec rake`

# Common configuration

### Authentication
    @access_key_id
    @secret_access_key
    @session_token

### Launch Configuration
    @ami                       = UNSET_VALUE
    @instance_type             = UNSET_VALUE
    @region                    = UNSET_VALUE
    @availability_zone         = UNSET_VALUE

### Timeouts
    @instance_check_interval   = UNSET_VALUE
    @instance_ready_timeout    = UNSET_VALUE

### API
    @endpoint                  = UNSET_VALUE
    @version                   = UNSET_VALUE

### Environment Variables
    @tags                      = {}

### Acknowledgments

This fork is based on [Vagrant AWS plugin](https://github.com/mitchellh/vagrant-aws).
