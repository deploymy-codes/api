require 'bundler/setup'

module Dmc

  PROVIDERS = [:github, :bitbucket]

  class << self
    def env
      ENV.fetch 'RACK_ENV', 'development'
    end
  end
end

require_relative 'lib/validation_error'
require_relative 'lib/form'
require_relative 'lib/serializer'

require_relative 'models/account'
require_relative 'models/user'

require_relative 'serializers/user_serializer'

require_relative 'repos/account_repo'

require_relative 'forms/code_form'

#require_relative 'services/github_service'
#require_relative 'services/github_service/octokit_github_service'
#require_relative 'services/github_service/fake_github_service'

#require_relative 'use_cases/find_or_create_user'

root = File.dirname __FILE__
config_file = "#{root}/config/#{Dmc.env}.rb"
require config_file
