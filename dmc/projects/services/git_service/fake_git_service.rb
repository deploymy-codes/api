module Projects
  class FakeGitService

    GitBranch = Struct.new(:name)
    GitTag    = Struct.new(:name)
    GitCommit = Struct.new(:id)

    def clone(dir, _)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end

    def branches(_)
      [GitBranch.new('develop')]
    end

    def tags(_)
      [GitTag.new('v-0.0.0')]
    end

    def total_commit(_)
      100
    end

    def commits(_, _)
      [GitCommit.new('a8955f57f76d1b77d1e7a61911f1da369863817e')]
    end
  end
end
