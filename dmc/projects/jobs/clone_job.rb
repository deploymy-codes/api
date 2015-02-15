module Projects
  class CloneJob
    include Sidekiq::Worker

    def perform(project)
      Clone.new(project).run!
    end

  end
end
