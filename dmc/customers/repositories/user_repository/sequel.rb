module Customers
  class UserRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_user_with_oauth_token(klass, selector)
        account_mapper = mapper_for Customers::Account
        account = account_mapper.first(oauth_token: selector.oauth_token)

        return unless account.present?

        mapper_for(klass).first(id: account[:user_id])
      end

      def query_user_with_email(klass, selector)
        mapper_for(klass).first(email: selector.email)
      end

      def query_user_with_api_key(klass, selector)
        mapper_for(klass).first(api_key: selector.api_key)
      end

      def clear
        mapper_for(User).delete
      end

    end
  end
end
