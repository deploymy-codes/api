require 'octokit'
require 'interchange'

module Customer
  PROVIDERS = [:github]
end

require_relative 'models/account'
require_relative 'models/user'

require_relative 'serializers/user_serializer'

require_relative 'repos/user_repo'
require_relative 'repos/adapter/in_memory'

require_relative 'forms/code_form'

require_relative 'services/github_service'
require_relative 'services/github_service/octokit_github_service'
require_relative 'services/github_service/fake_github_service'

require_relative 'use_cases/find_or_create_user'
