module Projects
  class FakeGitService

    def clone(dir, _)
      unless File.directory?(dir)
        FileUtils.mkdir_p(dir)
      end
    end

  end
end
