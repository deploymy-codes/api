module Projects
  class FakeGitService

    GitBranch = Struct.new(:name)
    GitTag    = Struct.new(:name)

    def clone(dir, _)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end

    def branches(dir)
      [GitBranch.new('develop')]
    end

    def tags(dir)
      [GitTag.new('v-0.0.0')]
    end
  end
end
