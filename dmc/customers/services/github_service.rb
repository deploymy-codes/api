module Customers
  class GithubService
    extend Interchange.new(*[:fetch_token, :user, :reset_tokens, :repositories, :repository])

    Repository = Struct.new(:name, :url, :id) do
      def to_hash
        Hash[members.zip values]
      end
    end

  end
end
