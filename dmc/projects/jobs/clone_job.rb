module Projects
  class CloneJob
    include Sidekiq::Worker

    def perform(project_id)
      project = ProjectRepository.find Project, project_id
      Clone.new(project).run!
    end

  end
end
