require 'bundler/setup'

module DMC
  class << self
    def env
      ENV.fetch 'RACK_ENV', 'development'
    end

    def root
      root = File.dirname __FILE__
      def root.join(*params)
        ::File.join(self, *params)
      end
      root
    end
  end
end

require_relative 'lib/framework'
require_relative 'customer/customer'
require_relative 'deploy/deploy'
require_relative 'orm/perpetuity'

config_file = "#{DMC.root}/config/#{DMC.env}.rb"
require config_file
