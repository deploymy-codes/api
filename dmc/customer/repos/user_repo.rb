module Customer
  class UserRepo < Repo

    class UnknownOauthTokenError < StandardError
      def initialize(oauth_token)
        @oauth_token = oauth_token
      end

      def to_s
        "Could not identifiy user with oauth token: #{@oauth_token}"
      end
    end

    def self.find_by_oauth_token!(oauth_token)
      user = query User, UserWithOauthToken.new(oauth_token)

      raise UnknownOauthTokenError, oauth_token if user.nil?

      user
    end

  end
  UserWithOauthToken = Struct.new :token
end

