This plugin provides a shell-script provider based on a gutted
vagrant-aws plugin.  Instead of calling to fog, it executes scripts.

# Getting Started
Install dependencies with bundler: `bundle install --path vendor/bundle`

Source `script/profile` to tune vagrant warnings and gem paths.  Only
tested on bash.

Runs tests: `rake`
