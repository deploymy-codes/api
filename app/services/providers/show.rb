module Providers
  class Show < DeployMyCodes::Service

    def call
      repository.projects(params[:account])
    end

    private

    def repository
      @repository ||= "#{params[:name].classify}Repository".constantize.new
    end

  end
end
