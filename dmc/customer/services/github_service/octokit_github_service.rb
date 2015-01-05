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

    def repositories(oauth_token)
      client = Octokit::Client.new(access_token: oauth_token, auto_paginate: true)

      user_repositories(client) + organization_repositories(client)
    end

    private

    def user_repositories(client)
      client.repositories.map do |attributes|
        build_repository attributes
      end
    end

    def organization_repositories(client)
      client.organizations.map do |organization|
        client.org_repos(organization.login).map do |attributes|
          build_repository attributes
        end
      end
    end

    def build_repository(attributes)
      GithubService::Repository.new attributes[:full_name], attributes[:clone_url]
    end

  end
end
