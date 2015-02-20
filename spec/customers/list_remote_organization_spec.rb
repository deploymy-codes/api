require 'spec_helper'

module Customers
  describe 'List remote organization' do

    let(:user)     { create_user }

    it 'returns the list' do
      remote_organizations = ListRemoteOrganization.new(user).run!

      expect(remote_organizations.length).to be_eql 1

      remote_organization = remote_organizations.first
      expect(remote_organization.name).to be_eql 'deploymy-codes'
      expect(remote_organization.avatar_url).to be_eql 'https://avatars.githubusercontent.com/u/9341835?v=3'
    end

  end
end
