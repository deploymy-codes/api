module Providers
  class List < DeployMyCodes::Service

    def call
      Constants.account.providers
    end

  end
end
