module Projects
  class Find < Struct.new(:id)

    def run!
      ProjectRepository.find(Project, id)
    end

  end
end
