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
require_relative 'orm/perpetuity'

Customer::UserRepository.register :in_memory, Customer::Repository::Adapter::InMemory.new
Customer::UserRepository.register :perpetuity, Customer::Repository::Adapter::Perpetuity.new
Customer::GithubService.register :fake, Customer::FakeGithubService.new


config_file = "#{DMC.root}/config/#{DMC.env}.rb"
require config_file
