module Providers
  class List < DeployMyCodes::Service

    def call
      Account::PROVIDER
    end

  end
end
