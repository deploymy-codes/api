module Customers
  class UserRepository
    class Perpetuity < ::Repository::Adapter::Perpetuity

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
        mapper_for(User).delete_all
      end

    end
  end
end
