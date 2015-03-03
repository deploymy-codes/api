module Deployments
  class ListLog < Struct.new(:deployment)

    def run!
      LogRepository.all_for_deployment!(deployment.id)
    end

  end
end
