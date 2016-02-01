require 'json'

module VagrantPlugins
  module Shell
    module Util
      class Run
        def self.run(env, cmd, *args)
          output=''
          IO.popen([env, cmd, *args]) { |o| output<< o.read }
          JSON.load(output)
        end
      end
    end
  end
end
