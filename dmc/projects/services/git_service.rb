module Projects
  class GitService
    extend Interchange.new(*[:clone, :branches, :tags, :commits, :total_commit, :commit, :pull])
  end
end
