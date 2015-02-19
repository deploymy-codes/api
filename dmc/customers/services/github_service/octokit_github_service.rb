module Customers
  class OctokitGithubService < Struct.new(:client_id, :client_secret)

    def fetch_token(code)
      data = Octokit.exchange_code_for_token(code, client_id, client_secret)
      data[:access_token]
    end

    def user(oauth_token)
      client(oauth_token).user
    end

    def organizations(oauth_token)
      client(oauth_token).orgs.map do |attributes|
        GithubService::Organization.new attributes[:login], attributes[:avatar_url]
      end
    end

    def repositories(oauth_token)
      client = client(oauth_token)
      user_repositories(client) + organization_repositories(client)
    end

    def repository(oauth_token, owner, repo)
      attributes = client(oauth_token).repo [owner, repo].join('/')

      build_repository attributes
    end

    def reset_tokens(oauth_token)
      client = Octokit::Client.new(client_id: client_id, client_secret: client_secret)
      client.reset_application_authorization(oauth_token)
    end

    private

    def client(oauth_token)
      Octokit::Client.new(access_token: oauth_token, auto_paginate: true)
    end

    def user_repositories(client)
      client.repositories.map do |attributes|
        build_repository attributes
      end
    end

    def organization_repositories(client)
      client.organizations.flat_map do |organization|
        client.org_repos(organization.login).map do |attributes|
          build_repository attributes
        end
      end
    end

    def build_repository(attributes)
      GithubService::Repository.new attributes[:full_name], attributes[:clone_url], attributes[:id]
    end

  end
end
