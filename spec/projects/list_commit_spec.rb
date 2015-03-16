require 'spec_helper'

module Projects
  describe 'List commit' do

    it 'list commit of the project' do
      user = create_user

      remote_project = Customers::RemoteProject.new(full_name: 'deploymy-codes/api', url: 'https://github.com/deploymy-codes/api.git', id: 25465783)
      project = Create.new(user, remote_project).run!

      envelope = ListCommit.new(project, Cursor.new).run!

      expect(envelope.data.first.id).to_not be_empty
    end
  end
end
