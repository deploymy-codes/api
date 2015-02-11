module Customers
  class AccountRepository < Repository

    class UnknownProviderForUserError < StandardError
      def initialize(provider, user_id)
        @provider = provider
        @user_id  = user_id
      end

      def to_s
        "Could not identifiy account with provider: #{@provider} for user: #{@user_id}"
      end
    end

    class << self
      def find_by_provider_and_user_id!(provider, user_id)
        account = query Account, AccountWithProviderAndUserId.new(provider, user_id)

        raise UnknownProviderForUserError.new(provider, user_id) if account.nil?

        account
      end
    end

  end

  AccountWithProviderAndUserId = Struct.new :provider, :user_id
end
