require 'spec_helper'

module Deploy
  describe 'List environment' do

    it 'list environment which belongs to the project' do
      user        = create_user
      project     = create_project name: 'rails', user: user
      environment = create_environment project: project

      environments = ListEnvironment.new(project).run!

      expect(environments.length).to be 2
      expect(environments.last.name).to be_eql environment.name
    end
  end
end
