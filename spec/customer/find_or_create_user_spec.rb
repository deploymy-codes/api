require 'spec_helper'

module Customer
  describe 'Find Or Create User' do

    context 'When provider is not available' do
      it 'raise a permissoin denied error' do
        code_form = CodeForm.new code: 'code'
        expect {
          FindOrCreateUser.new(:other, code_form).run!
        }.to raise_error PermissionDeniedError
      end
    end

    context 'When user does not exists' do
      it 'returns a new user' do
        code_form = CodeForm.new code: 'code'
        user = FindOrCreateUser.new(:github, code_form).run!

      end
    end
  end
end
