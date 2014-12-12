require 'bundler/setup'

module DMC
  class << self
    def env
      ENV.fetch 'RACK_ENV', 'development'
    end
  end
end

require_relative 'lib/framework'
require_relative 'customer/customer'
require_relative 'deploy/deploy'

root = File.dirname __FILE__
config_file = "#{root}/config/#{DMC.env}.rb"
require config_file
