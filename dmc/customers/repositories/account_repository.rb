module Customers
  class AccountRepository < Repository

    class UnknownProviderError < StandardError
      def initialize(provider)
        @provider = provider
      end

      def to_s
        "Could not identifiy account with provider: #{@provider} for current user"
      end
    end

    class << self
      def find_by_provider_and_user_id!(provider, user_id)
        account = query Account, AccountWithProviderAndUserId.new(provider, user_id)

        raise UnknownProviderError, provider if account.nil?

        account
      end
    end

  end

  AccountWithProviderAndUserId = Struct.new :provider, :user_id
end
