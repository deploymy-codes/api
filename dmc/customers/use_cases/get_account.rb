module Customers
  class GetAccount < Struct.new(:provider, :user_id)

    def run!
      AccountRepository.find_by_provider_and_user_id! provider, user_id
    end

  end
end
