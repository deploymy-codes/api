require 'bundler/setup'


module DMC
  class << self
    def env
      ENV.fetch 'RACK_ENV', 'development'
    end

    def root
      root = "#{File.dirname(__FILE__)}/dmc"

      def root.join(*params)
        ::File.join(self, *params)
      end

      root
    end
  end
end

require 'dotenv'
Dotenv.load(".env.#{DMC.env}")

require_relative 'dmc/lib/framework'
JobRunner.register :async, JobRunner::Async.new
JobRunner.register :sync,  JobRunner::Sync.new

require_relative 'dmc/customers'
require_relative 'dmc/projects'
require_relative 'dmc/environments'
require_relative 'dmc/deployments'

require_relative 'dmc/orm/sequel'

config_file = "#{DMC.root}/config/#{DMC.env}.rb"
require config_file
