module Customers
  class AccountRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_account_with_provider_and_user_id(klass, selector)
        all(klass).find { |account| account.provider == selector.provider && account.user_id == selector.user_id }
      end

    end
  end
end
