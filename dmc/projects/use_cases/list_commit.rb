module Projects
  class ListCommit < Struct.new(:project, :cursor)

    def run!
      Envelope.new commits, total_commit, cursor
    end

    private

    def total_commit
      GitService.total_commit project.dir
    end

    def commits
      @commits ||= git_commits.map { |git_commit| Commit.new id: git_commit.id }
    end

    def git_commits
      @git_commits ||= GitService.commits project.dir, cursor
    end

  end
end
