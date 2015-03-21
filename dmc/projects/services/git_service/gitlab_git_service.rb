module Projects
  class GitlabGitService

    def clone(dir, url, oauth_token)
      Rugged::Repository.clone_at url, dir, credentials: credentials(oauth_token)
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

    def commit(dir, sha)
      Gitlab::Git::Commit.find(repo(dir), sha)
    end

    def pull(dir, name)
      repo(dir).fetch(name)
    end

    private

    def repo(dir)
      Gitlab::Git::Repository.new(dir)
    end

    def credentials(oauth_token)
      Rugged::Credentials::UserPassword.new(username: oauth_token, password: 'x-oauth-basic')
    end

  end
end
