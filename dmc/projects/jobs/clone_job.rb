module Projects
  class CloneJob
    include Sidekiq::Worker

    def perform(project_id)
      project = Find.new(project_id).run!
      Clone.new(project).run!
    end

  end
end
