require 'spec_helper'

module Customers
  describe 'List remote project' do

    let(:user)     { create_user }
    let!(:project) { create_project user: user }

    it 'returns the list' do
      cursor = ListRemoteProject.new(user, Cursor.new).run!

      expect(cursor.total_count).to be_eql 3

      remote_project = cursor.data.first
      expect(remote_project.name).to be_eql 'deploymy-codes/api'
      expect(remote_project.url).to be_eql 'https://github.com/deploymy-codes/api.git'
      expect(remote_project.imported).to be true
    end

  end
end
