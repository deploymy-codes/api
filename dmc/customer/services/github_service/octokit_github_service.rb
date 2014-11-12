module Customer
  class OctokitGithubService

    def initialize(client_id, client_secret)
      @client_id     = client_id
      @client_secret = client_secret
    end

    def fetch_token(code)
      Octokit.exchange_code_for_token(code, @client_id, @client_secret, { accept: 'application/json' })
    end

    def user(oauth_token)
    end

  end
end
