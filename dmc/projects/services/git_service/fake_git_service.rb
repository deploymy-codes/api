module Projects
  class FakeGitService

    GitBranch = Struct.new(:name)

    def clone(dir, _)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end

    def branches(dir)
      [GitBranch.new('develop')]
    end

  end
end
