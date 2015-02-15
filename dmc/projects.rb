require 'interchange'

require_relative 'projects/entities/project'

require_relative 'projects/serializers/project_serializer'

require_relative 'projects/repositories/project_repository'
require_relative 'projects/repositories/project_repository/in_memory'
require_relative 'projects/repositories/project_repository/perpetuity'

require_relative 'projects/services/git_service'
require_relative 'projects/services/git_service/rugged_git_service'
require_relative 'projects/services/git_service/fake_git_service'

require_relative 'projects/use_cases/create'
require_relative 'projects/use_cases/list'
require_relative 'projects/use_cases/find'

module Projects
  ProjectRepository.register :in_memory,  ProjectRepository::InMemory.new
  ProjectRepository.register :perpetuity, ProjectRepository::Perpetuity.new

  GitService.register :fake, FakeGitService.new
end
