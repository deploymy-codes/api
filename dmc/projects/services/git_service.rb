module Projects
  class GitService
    extend Interchange.new(*[:clone, :branches, :tags])
  end
end
