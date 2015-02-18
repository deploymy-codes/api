module Projects
  class List < Struct.new(:user)

    def run!
      ProjectRepository.all(Project)
    end

  end
end
