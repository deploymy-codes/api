require 'spec_helper'

module Deployments
  describe 'List deployment' do

    it 'list deployment which belongs to the environment' do
      user        = create_user
      project     = create_project name: 'rails', user: user
      environment = create_environment project: project
      deployment  = create_deployment commit: 'yaha', environment: environment

      deployments = List.new(environment).run!

      expect(deployments.length).to be 1
      expect(deployments.last.commit).to be_eql deployment.commit
      expect(deployments.last.environment_id).to be_eql deployment.environment_id
    end
  end
end
