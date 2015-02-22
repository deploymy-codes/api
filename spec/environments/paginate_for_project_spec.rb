require 'spec_helper'

module Environments
  describe 'Paginate environment for project' do

    it 'list environment which belongs to the project' do
      user        = create_user
      project     = create_project full_name: 'rails', user: user
      environment = create_environment project: project

      envelope = PaginateForProject.new(project, Cursor.new).run!

      expect(envelope.total_count).to be 2
      expect(envelope.data.last.name).to be_eql environment.name
    end
  end
end
