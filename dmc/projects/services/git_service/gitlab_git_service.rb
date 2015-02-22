module Projects
  class GitlabGitService

    def clone(dir, url)
      Rugged::Repository.clone_at url, dir
    end

    def branches(dir)
      repo(dir).branches
    end

    def tags(dir)
      repo(dir).tags
    end

    def commits(dir, cursor, reference: 'master')
      Gitlab::Git::Commit.where(
        repo:   repo(dir),
        limit:  cursor.limit,
        offset: cursor.offset,
      )
    end

    def total_commit(dir)
      repo(dir).commit_count repo(dir).root_ref
    end

    private

    def repo(dir)
      Gitlab::Git::Repository.new(dir)
    end

  end
end
