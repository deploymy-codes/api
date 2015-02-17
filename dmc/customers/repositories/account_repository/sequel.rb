module Customers
  class AccountRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_account_with_provider_and_user_id(klass, selector)
        mapper_for(klass).first(provider: selector.provider, user_id: selector.user_id)
      end

      def clear
        mapper_for(Account).delete
      end

    end
  end
end
