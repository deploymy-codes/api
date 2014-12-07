require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Self' do

  def app
    Users
  end

  context 'When api key is not present' do
    it 'returns a 412' do
      get '/self'

      expect(last_response.status).to be_eql 412
    end
  end

  context 'When user corresponding to the api key does not exist' do
    it 'returns a 403' do
      get '/self', {}, { 'API_KEY' => 'random' }

      expect(last_response.status).to be_eql 403
    end
  end

  context 'When user is found' do
    let!(:user) do
      code_form = Customer::CodeForm.new code: 'code'
      Customer::FindOrCreateUser.new(:github, code_form).run!
    end

    it 'returns it' do
      get '/self', {}, { 'API_KEY' => user.api_key }

      expect(last_response.status).to be_eql 200
      json = JSON.parse(last_response.body)
      expect(json).to be_instance_of Hash
      expect(json['api_key']).to be_eql user.api_key
    end
  end
end
