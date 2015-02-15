module Deployments
  class Create < Struct.new(:environment, :form)

    def run!
      form.validate!

      deployment = Deployment.build(form.commit, environment.id)
      DeploymentRepository.save deployment

      deployment
    end

  end
end
