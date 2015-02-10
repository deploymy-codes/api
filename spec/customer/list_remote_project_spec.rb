require 'spec_helper'

module Customers
  describe 'List remote project' do

    let(:user) { create_user }

    it 'returns the list' do
      remote_projects = ListRemoteProject.new(user).run!

      expect(remote_projects.length).to be_eql 3

      remote_project = remote_projects.first
      expect(remote_project.name).to be_eql 'rails'
      expect(remote_project.url).to be_eql 'https://github.com/rails/rails'
    end

  end
end
