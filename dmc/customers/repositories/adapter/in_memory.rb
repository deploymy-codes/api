module Customers
  module Repository
    module Adapter
      class InMemory < ::Repository::Adapter::InMemory

        def query_user_with_oauth_token(klass, selector)
          all(klass).find { |user| user.accounts.map(&:oauth_token).include? selector.oauth_token }
        end

        def query_user_with_email(klass, selector)
          all(klass).find { |user| user.email == selector.email }
        end

        def query_user_with_api_key(klass, selector)
          all(klass).find { |user| user.api_key == selector.api_key }
        end
      end
    end
  end
end
