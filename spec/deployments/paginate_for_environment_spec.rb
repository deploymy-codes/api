require 'spec_helper'

module Deployments
  describe 'Paginate deployment for environment' do

    it 'list deployment which belongs to the environment' do
      user        = create_user
      project     = create_project full_name: 'rails', user: user
      environment = create_environment project: project
      deployment  = create_deployment environment: environment

      envelope = PaginateForEnvironment.new(environment, Cursor.new).run!

      expect(envelope.total_count).to be 1
      expect(envelope.data.last.sha).to be_eql deployment.sha
      expect(envelope.data.last.environment_id).to be_eql deployment.environment_id
    end
  end
end
