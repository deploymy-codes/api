module Projects
  class ListCommit < Struct.new(:project)

    def run!
      git_commits = GitService.commits project.dir

      git_commits.map { |git_commit| Commit.new oid: git_commit.oid }
    end

  end
end
