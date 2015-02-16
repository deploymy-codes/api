module Projects
  class GitService
    extend Interchange.new(*[:clone, :branches, :tags, :commits])
  end
end
