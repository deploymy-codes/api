require 'bundler/setup'

module Dmc
  class << self
    def env
      ENV.fetch 'RACK_ENV', 'development'
    end
  end
end

require_relative 'lib/framework'
require_relative 'customer/customer'

root = File.dirname __FILE__
config_file = "#{root}/config/#{Dmc.env}.rb"
require config_file
