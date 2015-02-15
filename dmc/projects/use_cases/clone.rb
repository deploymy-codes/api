module Projects
  class Clone < Struct.new(:project)

    def run!
      GitService.clone project.dir, project.url
    end

  end
end
