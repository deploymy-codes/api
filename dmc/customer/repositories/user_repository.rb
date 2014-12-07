module Customer
  class UserRepository < Repository

    class UnknownOauthTokenError < StandardError
      def initialize(oauth_token)
        @oauth_token = oauth_token
      end

      def to_s
        "Could not identifiy user with oauth token: #{@oauth_token}"
      end
    end

    class UnknownEmailError < StandardError
      def initialize(email)
        @email = email
      end

      def to_s
        "Could not identifiy user with email: #{@email}"
      end
    end

    class << self
      def find_by_oauth_token!(oauth_token)
        user = query User, UserWithOauthToken.new(oauth_token)

        raise UnknownOauthTokenError, oauth_token if user.nil?

        user
      end

      def find_by_email!(email)
        user = query User, UserWithEmail.new(email)

        raise UnknownEmailError, email if user.nil?

        user
      end
    end

  end

  UserWithOauthToken = Struct.new :oauth_token
  UserWithEmail = Struct.new :email
end
