module Deployments
  class CreateLog < Struct.new(:form, :deployment_id)

    def run!
      form.validate!

      log = Log.new form.attributes.merge(deployment_id: deployment_id)
      LogRepository.save log

      log
    end

  end
end
