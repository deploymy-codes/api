module Customer
  class GithubService
    extend Interchange.new(*[:fetch_token, :user, :reset_tokens, :repositories])

    Repository = Struct.new(:name, :url) do
      def to_hash
        Hash[members.zip values]
      end
    end

  end
end
