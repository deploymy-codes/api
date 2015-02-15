module Customers
  class UserRepository
    class InMemory < ::Repository::Adapter::InMemory

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
