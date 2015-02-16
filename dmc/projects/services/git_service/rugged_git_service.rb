module Projects
  class RuggedGitService

    def clone(dir, url)
      Rugged::Repository.clone_at url, dir
    end

    def branches(dir)
      repo(dir).branches
    end

    def tags(dir)
      repo(dir).tags
    end

    def commits(dir, branch = nil)
      repo = repo(dir)
      walker = Rugged::Walker.new(repo)
      walker.sorting(Rugged::SORT_TOPO | Rugged::SORT_REVERSE)

      target = if branch.nil?
                 repo.head.target
               else
                 repo.branches[remote_branch].target_id
               end

      walker.push target
      walker.to_a
    end

    private

    def repo(dir)
      Rugged::Repository.new(dir)
    end

  end
end
