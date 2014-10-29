require 'rails_helper'

RSpec.describe 'Accounts' do

  describe '#create' do
    context 'When the user does not exists' do
      it 'creates a new user and new account' do
        expect {
          post 'accounts', email: 'foo@bar.com', provider: 'github', oauth_token: 'token', first_name: 'foo', last_name: 'bar'
        }.to change { User.count }.to(1)


        user = User.last
        expect(user.email).to be_eql 'foo@bar.com'
        expect(user.first_name).to be_eql 'foo'
        expect(user.last_name).to be_eql 'bar'

        account = user.accounts.first
        expect(account.provider).to be_eql 'github'
        expect(account.oauth_token).to be_eql 'token'
      end
    end

    context 'When the user exists' do
      let!(:user) { create(:user, email: 'foo@bar.com') }

      context 'When the user already has this provider' do
        let!(:account) { create(:account, :github, user_id: user.id) }

        it 'updates the provider' do
          post 'accounts', email: 'foo@bar.com', provider: 'github', oauth_token: 'token', first_name: 'foo', last_name: 'bar'
        end
      end

      context 'When the user does not have this provider' do
        it 'create the provider' do
          expect {
            post 'accounts', email: 'foo@bar.com', provider: 'github', oauth_token: 'token', first_name: 'foo', last_name: 'bar'
          }.to change { Account.count }.to(1)

        end
      end
    end
  end

end
