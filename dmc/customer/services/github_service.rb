module Customer
  class GithubService
    extend Interchange.new(*[:fetch_token, :user])
  end
end
