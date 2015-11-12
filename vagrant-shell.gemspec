$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-aws/version"

Gem::Specification.new do |s|
  s.name          = "vagrant-aws"
  s.version       = VagrantPlugins::AWS::VERSION
  s.platform      = Gem::Platform::RUBY
  s.license       = "MIT"
  s.authors       = "Mitchell Hashimoto"
  s.email         = "mitchell@hashicorp.com"
  s.homepage      = "https://github.com/defn/vagrant-shell"
  s.summary       = "Vagrant provider using shell-scripts"
  s.description   = "Vagrant provider using shell-scripts (based on vagrant-aws)"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.12"
  s.add_development_dependency "rspec-its"

  s.files         = %x{git ls-files}.split("\n")
  s.executables   = []
  s.require_path  = 'lib'
end
