require 'spec_helper'

module Customers
  describe 'Find Or Create User' do
    let(:form)  { CodeForm.new code: 'code' }

    context 'When provider is not available' do
      it 'raise a permissoin denied error' do
        expect {
          FindOrCreate.new(:other, form).run!
        }.to raise_error PermissionDeniedError
      end
    end

    context 'When user does not exists' do
      it 'returns a new user' do
        user    = FindOrCreate.new('github', form).run!
        account = AccountRepository.first Account

        expect(user.persisted?).to be true
        expect(account.provider).to be_eql 'github'
      end
    end

    context 'When user exists' do
      let!(:user) { FindOrCreate.new('github', form).run! }

      subject { FindOrCreate.new('github', form).run! }

      it 'returns the same user' do
        expect(subject.id).to be_eql user.id
      end

      context 'When the tokens is the same' do
        it 'does not update the oauth token' do
          first_token = AccountRepository.first(Account).oauth_token

          subject

          account = AccountRepository.first(Account)
          expect(account.oauth_token).to be_eql first_token
        end
      end

      context 'When the tokens has change' do
        let(:new_form) { CodeForm.new code: 'new-code' }

        it 'updates the oauth token' do
          first_token = AccountRepository.first(Account).oauth_token
          GithubService.reset_tokens(first_token)

          FindOrCreate.new('github', new_form).run!

          account = AccountRepository.first(Account)
          expect(account.oauth_token).to_not be_eql first_token
        end
      end
    end

  end
end
