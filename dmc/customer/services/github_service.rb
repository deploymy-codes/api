module Customer
  class GithubService
    extend Interchange.new(*[:fetch_token, :user, :reset_tokens])
  end
end
