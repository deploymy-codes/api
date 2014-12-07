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

Customer::UserRepository.register :in_memory, Customer::Repository::Adapter::InMemory.new
Customer::GithubService.register :fake, Customer::FakeGithubService.new


root = File.dirname __FILE__
config_file = "#{root}/config/#{DMC.env}.rb"
require config_file
