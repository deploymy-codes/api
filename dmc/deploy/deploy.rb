require 'interchange'

require_relative 'entities/project'

require_relative 'serializers/project_serializer'

require_relative 'repositories/project_repository'
require_relative 'repositories/adapter/in_memory'
require_relative 'repositories/adapter/perpetuity'

require_relative 'services/git_service'
require_relative 'services/git_service/rugged_git_service'
require_relative 'services/git_service/fake_git_service'

require_relative 'use_cases/create_project'

module Deploy
  ProjectRepository.register :in_memory, Repository::Adapter::InMemory.new
  ProjectRepository.register :perpetuity, Repository::Adapter::Perpetuity.new
  GitService.register       :fake,      FakeGitService.new
end
