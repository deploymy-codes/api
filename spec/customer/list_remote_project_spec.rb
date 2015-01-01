require 'spec_helper'

module Customer
  describe 'List remote project' do

    let(:user) do
      code_form = CodeForm.new code: 'code'
      FindOrCreateUser.new('github', code_form).run!
    end

    it 'returns the list' do
      remote_projects = ListRemoteProject.new(user).run!

      expect(remote_projects.length).to be_eql 3

      remote_project = remote_projects.first
      expect(remote_project.name).to be_eql 'rails'
      expect(remote_project.url).to be_eql 'https://github.com/rails/rails'
    end

  end
end
