module Deployments
  class GithubService
    extend Interchange.new(*[:create_release])
  end
end
