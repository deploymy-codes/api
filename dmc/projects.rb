require 'interchange'
require 'rugged'

require_relative 'projects/entities/project'
require_relative 'projects/entities/branch'
require_relative 'projects/entities/tag'
require_relative 'projects/entities/commit'

require_relative 'projects/serializers/project_serializer'
require_relative 'projects/serializers/branch_serializer'
require_relative 'projects/serializers/tag_serializer'
require_relative 'projects/serializers/commit_serializer'

require_relative 'projects/repositories/project_repository'
require_relative 'projects/repositories/project_repository/in_memory'
require_relative 'projects/repositories/project_repository/sequel'

require_relative 'projects/services/git_service'
require_relative 'projects/services/git_service/rugged_git_service'
require_relative 'projects/services/git_service/fake_git_service'

require_relative 'projects/jobs/clone_job'

require_relative 'projects/use_cases/create'
require_relative 'projects/use_cases/list'
require_relative 'projects/use_cases/list_for_user'
require_relative 'projects/use_cases/paginate_for_user'
require_relative 'projects/use_cases/find_by_name'
require_relative 'projects/use_cases/find'
require_relative 'projects/use_cases/clone'
require_relative 'projects/use_cases/list_branch'
require_relative 'projects/use_cases/list_tag'
require_relative 'projects/use_cases/list_commit'

module Projects
  ProjectRepository.register :in_memory,  ProjectRepository::InMemory.new
  ProjectRepository.register :sequel, ProjectRepository::Sequel.new

  GitService.register :fake, FakeGitService.new
  GitService.register :rugged, RuggedGitService.new
end
