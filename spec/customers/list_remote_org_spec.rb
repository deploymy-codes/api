require 'spec_helper'

module Customers
  describe 'List remote org' do

    let(:user)     { create_user }

    it 'returns the list' do
      remote_orgs = ListRemoteOrg.new(user).run!

      expect(remote_orgs.length).to be_eql 1

      remote_org = remote_orgs.first
      expect(remote_org.name).to be_eql 'deploymy-codes'
      expect(remote_org.avatar_url).to include 'avatar'
    end

  end
end
