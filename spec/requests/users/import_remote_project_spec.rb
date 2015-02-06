require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Import remote projects' do
  it_behaves_like 'Authenticated', '/remote_projects/rails/import', 'post'

  def app
    Users
  end

  let!(:user) { create_user }

  it 'return the project' do
    post '/remote_projects/rails/import', {}, { 'API_KEY' => user.api_key }

    expect(last_response.status).to be_eql 201
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['remote_name']).to be_eql 'rails'
    expect(json['name']).to be_eql 'rails'
  end

  context 'when the project has already been imported' do
    it 'returns a 403 errors' do
      post '/remote_projects/rails/import', {}, { 'API_KEY' => user.api_key }
      post '/remote_projects/rails/import', {}, { 'API_KEY' => user.api_key }

      expect(last_response.status).to be_eql 403
      json = JSON.parse(last_response.body)
      expect(json['error']['message']).to be_eql 'Project name rails is already taken'
    end
  end
end
