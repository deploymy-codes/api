module Customers
  module Repository
    module Adapter
      class InMemory < ::Repository::Adapter::InMemory

        def query_account_with_provider_and_user_id(klass, selector)
          all(klass).find { |account| account.provider == selector.provider && account.user_id == selector.user_id }
        end

        def query_user_with_oauth_token(klass, selector)
          account = all(Customers::Account).find { |a| a.oauth_token == selector.oauth_token }

          return unless account.present?

          all(klass).find { |user| user.id == account.id }
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
