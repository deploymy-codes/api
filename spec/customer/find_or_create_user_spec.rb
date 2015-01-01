require 'spec_helper'

module Customer
  describe 'Find Or Create User' do
    let(:form)  { CodeForm.new code: 'code' }

    context 'When provider is not available' do
      it 'raise a permissoin denied error' do
        expect {
          FindOrCreateUser.new(:other, form).run!
        }.to raise_error PermissionDeniedError
      end
    end

    context 'When user does not exists' do
      it 'returns a new user' do
        user = FindOrCreateUser.new(:github, form).run!

        expect(user.persisted?).to be true
        expect(user.accounts.first.provider).to be_eql 'github'
      end
    end

    context 'When user exists' do
      let!(:user) { FindOrCreateUser.new(:github, form).run! }

      subject { FindOrCreateUser.new(:github, form).run! }

      it 'returns the same user' do
        expect(subject.id).to be_eql user.id
      end

      context 'When the tokens is the same' do
        it 'does not update the oauth token' do
          first_token = user.accounts.first.oauth_token
          expect(subject.accounts.first.oauth_token).to be_eql first_token
        end
      end

      context 'When the tokens has change' do
        before do
          GithubService.reset_tokens
        end

        it 'updates the oauth token' do
          first_token = user.accounts.first.oauth_token
          expect(subject.accounts.first.oauth_token).to_not be_eql first_token
        end
      end
    end

  end
end
