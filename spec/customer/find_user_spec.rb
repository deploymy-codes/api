require 'spec_helper'

module Customer
  describe 'Find User' do

    context 'When user is not found' do
      it 'raise a record not found error' do
        form = ApiKeyForm.new(api_key: 'api-key')

        expect {
          FindUser.new(form).run!
        }.to raise_error UserRepo::UnknownApiKeyError
      end
    end

    context 'When user is found' do
      let!(:user) do
        code_form = CodeForm.new code: 'code'
        FindOrCreateUser.new(:github, code_form).run!
      end

      it 'returns the user' do
        form        = ApiKeyForm.new(api_key: user.api_key)
        result_user = FindUser.new(form).run!

        expect(result_user.email).to be_eql user.email
      end
    end

  end
end
