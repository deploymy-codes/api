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

    private

    def repo(dir)
      Rugged::Repository.new(dir)
    end
  end
end
