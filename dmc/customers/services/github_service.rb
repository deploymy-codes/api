module Customers
  module Hashify
    def to_hash
      Hash[members.zip values]
    end
  end

  class GithubService
    extend Interchange.new(*[:fetch_token, :user, :reset_tokens, :organizations, :repositories, :repository])

    Repository = Struct.new(:name, :url, :id) do
      include Hashify
    end

    Organization = Struct.new(:name, :avatar_url) do
      include Hashify
    end

  end
end
