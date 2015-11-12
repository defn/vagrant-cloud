$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-aws/version"
require "pp"

Gem::Specification.new do |s|
  s.name          = "vagrant-aws"
  s.version       = VagrantPlugins::AWS::VERSION
  s.platform      = Gem::Platform::RUBY
  s.license       = "MIT"
  s.authors       = "Mitchell Hashimoto"
  s.email         = "mitchell@hashicorp.com"
  s.homepage      = "http://www.vagrantup.com"
  s.summary       = "Vagrant provider shell based on vagrant-aws"
  s.description   = "Vagrant provider shell based on vagrant-aws"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "vagrant-aws"

  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 2.12"
  s.add_development_dependency "rspec-its"

  s.files         = %x{git ls-files}.split("\n")
  s.executables   = []
  s.require_path  = 'lib'
end
