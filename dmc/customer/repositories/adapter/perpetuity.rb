module Customer
  module Repository
    module Adapter
      class Perpetuity < ::Repository::Adapter::Perpetuity

        def query_user_with_oauth_token(klass, selector)
          all(klass).find { |user| user.accounts.map(&:oauth_token).include? selector.oauth_token }
        end

        def query_user_with_email(klass, selector)
          all(klass).find { |user| user.email == selector.email }
        end

        def query_user_with_api_key(klass, selector)
          all(klass).find { |user| user.api_key == selector.api_key }
        end

        def clear
          ::Perpetuity[Customer::User].delete_all
          ::Perpetuity[Customer::Account].delete_all
        end
      end
    end
  end
end
