module Projects
  class FakeGitService

    GitBranch = Struct.new(:name)
    GitTag    = Struct.new(:name)
    GitCommit = Struct.new(:id)

    def clone(dir, _, _)
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
      [GitCommit.new(ENV['GIT_COMMIT_ID'])]
    end

    def commit(_, sha)
      if sha == ENV['GIT_COMMIT_ID']
        GitCommit.new(ENV['GIT_COMMIT_ID'])
      else
        nil
      end
    end

  end
end
