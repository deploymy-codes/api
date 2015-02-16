require 'spec_helper'

module Projects
  describe 'List commit' do

    it 'list commit of the project' do
      user = create_user

      remote_project = Customers::RemoteProject.new(name:'deploymy-codes/api', url: 'https://github.com/deploymy-codes/api.git', id: 25465783)
      project = Create.new(user, remote_project).run!

      commits = ListCommit.new(project).run!

      expect(commits.first.oid).to be_eql 'a8955f57f76d1b77d1e7a61911f1da369863817e'
    end
  end
end
