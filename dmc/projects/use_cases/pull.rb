module Projects
  class Pull < Struct.new(:form)

    def run!
      project = ProjectRepository.find_by_remote_id!(form.id)

      GitService.pull project.dir
    end

  end
end
