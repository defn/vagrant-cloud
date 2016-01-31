This plugin provides a shell-script provider based on a gutted
vagrant-aws plugin.  Instead of calling to fog, it executes scripts.
Machine configuration are exported as enviroment variables before
calling the scripts.

# Getting Started
Install dependencies with bundler: `bundle _1.10.6_ install --path vendor/bundle`

Source `script/profile` to tune vagrant warnings and gem paths.  Only
tested on bash.

Runs tests: `bundle _1.10.5_ exec rake`
