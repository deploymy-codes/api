module Customer
  module Repo
    module Adapter
      class ActiveRecord < ::Repo::Adapter::ActiveRecord

        def query_user_with_oauth_token(klass, selector)
          klass.find_by oauth_token: selector.oauth_token
        end

        def query_user_with_email(klass, selector)
          klass.find_by email: selector.email
        end

        def query_user_with_api_key(klass, selector)
          klass.find_by api_key: selector.api_key
        end
      end
    end
  end
end
