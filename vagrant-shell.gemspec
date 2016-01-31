$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-shell/version"

Gem::Specification.new do |s|
  s.name          = "vagrant-shell"
  s.version       = VagrantPlugins::Shell::VERSION
  s.platform      = Gem::Platform::RUBY
  s.license       = "MIT"
  s.authors       = [ "Mitchell Hashimoto", "Tom Bombadil" ]
  s.email         = [ "mitchell@hashicorp.com", "amanibhavam@destructuring.org" ]
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
