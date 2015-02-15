module Projects
  class GitService
    extend Interchange.new(*[:clone, :branches])
  end
end
