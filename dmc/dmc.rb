require 'bundler/setup'
require 'interchange'

module Dmc
  class << self
    def env
      ENV.fetch 'RACK_ENV', 'development'
    end
  end
end

require_relative 'lib/validation_error'
require_relative 'lib/unknown_form_field_error'
require_relative 'lib/record_not_found_error'

require_relative 'lib/form'
require_relative 'lib/serializer'
require_relative 'lib/persistence'

require_relative 'lib/repo'
require_relative 'lib/repo/in_memory'

require_relative 'customer/customer'

root = File.dirname __FILE__
config_file = "#{root}/config/#{Dmc.env}.rb"
require config_file
