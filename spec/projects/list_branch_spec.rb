require 'spec_helper'

module Projects
  describe 'List branch' do

    it 'list branch of the project' do
      user = create_user

      remote_project = Customers::RemoteProject.new(name:'deploymy-codes/api', url: 'https://github.com/deploymy-codes/api.git', id: 25465783)
      project = Create.new(user, remote_project).run!

      envelope = ListBranch.new(project, Cursor.new).run!

      expect(envelope.data.first.name).to be_eql 'develop'
    end
  end
end
