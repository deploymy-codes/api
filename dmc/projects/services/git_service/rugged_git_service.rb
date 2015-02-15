module Projects
  class RuggedGitService

    def clone(dir, url)
      Rugged::Repository.clone_at url, dir
    end

  end
end
