require 'octokit'
require 'interchange'

module Customer
  PROVIDERS = [:github]
end

require_relative 'entities/account'
require_relative 'entities/user'

require_relative 'serializers/user_serializer'

require_relative 'repositories/user_repository'
require_relative 'repositories/adapter/in_memory'

require_relative 'forms/code_form'
require_relative 'forms/api_key_form'

require_relative 'services/github_service'
require_relative 'services/github_service/octokit_github_service'
require_relative 'services/github_service/fake_github_service'

require_relative 'use_cases/find_or_create_user'
require_relative 'use_cases/find_user'
