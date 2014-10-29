module Providers
  class List < DeployMyCodes::Service

    def call
      provider_repository.all
    end

    private

    def provider_repository
      @provider_repository ||= ProviderRepository.new
    end

  end
end
