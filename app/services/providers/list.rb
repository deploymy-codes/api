module Providers
  class List < DeployMyCodes::Service

    def call
      Constants.providers
    end

  end
end
