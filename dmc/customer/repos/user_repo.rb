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

    class UnknownEmailError < StandardError
      def initialize(email)
        @email = email
      end

      def to_s
        "Could not identifiy user with email: #{@email}"
      end
    end

    class UnknownApiKeyError < StandardError
      def initialize(api_key)
        @api_key = api_key
      end

      def to_s
        "Could not identifiy user with api key: #{@api_key}"
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

      def find_by_api_key!(api_key)
        user = query User, UserWithApiKey.new(api_key)

        raise UnknownApiKeyError, api_key if user.nil?

        user
      end
    end

  end
  UserWithApiKey     = Struct.new :api_key
  UserWithOauthToken = Struct.new :oauth_token
  UserWithEmail      = Struct.new :email
end

