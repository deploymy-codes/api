require 'spec_helper'

module Customers
  describe 'Find User' do

    context 'When user is not found' do
      it 'raise a record not found error' do
        form = APIKeyForm.new(api_key: 'api-key')

        expect {
          FindUser.new(form).run!
        }.to raise_error UserRepository::UnknownApiKeyError
      end
    end

    context 'When user is found' do
      let!(:user) { create_user }

      it 'returns the user' do
        form        = APIKeyForm.new(api_key: user.api_key)
        result_user = FindUser.new(form).run!

        expect(result_user.email).to be_eql user.email
      end
    end

  end
end
