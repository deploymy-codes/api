require 'spec_helper'

module Deployments
  describe 'Paginate deployment for environment' do

    it 'list deployment which belongs to the environment' do
      user        = create_user
      project     = create_project name: 'rails', user: user
      environment = create_environment project: project
      deployment  = create_deployment commit: 'yaha', environment: environment

      envelope = PaginateForEnvironment.new(environment, Cursor.new).run!

      expect(envelope.total_count).to be 1
      expect(envelope.data.last.commit).to be_eql deployment.commit
      expect(envelope.data.last.environment_id).to be_eql deployment.environment_id
    end
  end
end
