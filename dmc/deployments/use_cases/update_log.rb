module Deployments
  class UpdateLog < Struct.new(:log, :form)

    def run!
      form.validate!

      log.attributes = form.attributes
      LogRepository.save log

      log
    end

  end
end
