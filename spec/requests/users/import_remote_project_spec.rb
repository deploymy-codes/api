require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Import remote projects' do

  def app
    Users
  end

  context 'When api key is not present' do
    it 'returns a 412' do
      post '/remote_projects/rails/import'

      expect(last_response.status).to be_eql 412
    end
  end

  context 'When user corresponding to the api key does not exist' do
    it 'returns a 403' do
      post '/remote_projects/rails/import', {}, { 'API_KEY' => 'random' }

      expect(last_response.status).to be_eql 403
    end
  end

  context 'When user is found' do
    let!(:user) do
      code_form = Customer::CodeForm.new code: 'code'
      Customer::FindOrCreateUser.new('github', code_form).run!
    end

    it 'return the project' do
      post '/remote_projects/rails/import', {}, { 'API_KEY' => user.api_key }

      expect(last_response.status).to be_eql 201
      json = JSON.parse(last_response.body)
      expect(json).to be_instance_of Hash
      expect(json['remote_name']).to be_eql 'rails'
      expect(json['name']).to be_eql 'rails'
    end
  end
end
