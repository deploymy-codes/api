module Customers
  class AccountRepository
    class Perpetuity < ::Repository::Adapter::Perpetuity

      def query_account_with_provider_and_user_id(klass, selector)
        account_mapper = mapper_for Customers::Account
        account_mapper.find { |account| account.provider == selector.provider && account.user_id == selector.user_id }
      end

      def query_user_with_oauth_token(klass, selector)
        account_mapper = mapper_for Customers::Account
        account = account_mapper.find { |a| a.oauth_token == selector.oauth_token }

        return unless account.present?

        user_mapper = mapper_for klass
        user_mapper.find { |user| user.id == account.user_id }
      end

      def query_user_with_email(klass, selector)
        mapper = mapper_for klass
        mapper.find { |user| user.email == selector.email }
      end

      def query_user_with_api_key(klass, selector)
        mapper = mapper_for klass
        mapper.find { |user| user.api_key == selector.api_key }
      end

      def clear
        mapper_for(Customers::Account).delete_all
      end

    end
  end
end
