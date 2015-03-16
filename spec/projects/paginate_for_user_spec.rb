require 'spec_helper'

module Projects
  describe 'Paginate project for user' do

    it 'list project which belongs to the user' do
      user = create_user

      remote_project = Customers::RemoteProject.new(full_name: 'deploymy-codes/api', url: 'https://github.com/deploymy-codes/api.git', id: 25465783)
      project = Create.new(user, remote_project).run!

      envelope = PaginateForUser.new(user, Cursor.new).run!

      expect(envelope.total_count).to be_eql 1
      expect(envelope.data.first.id).to be_eql project.id
      expect(envelope.data.first.name).to be_eql project.name
      expect(envelope.data.first.user_id).to be_eql project.user_id
    end
  end
end
