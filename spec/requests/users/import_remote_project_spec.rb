require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Import remote projects' do
  it_behaves_like 'Authenticated', '/deploymy-codes/remote_projects/api', 'post'

  def app
    Endpoint::Users
  end

  let!(:user) { create_user }

  it 'return the project' do
    post '/deploymy-codes/remote_projects/api', {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 201
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['remote_id']).to be_eql 25465783
    expect(json['name']).to be_eql 'deploymy-codes/api'
  end

  context 'when the project has already been imported' do
    it 'returns a 403 errors' do
      post '/deploymy-codes/remote_projects/api', {}, { 'HTTP_AUTHORIZATION' => user.api_key }
      post '/deploymy-codes/remote_projects/api', {}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 403
      json = JSON.parse(last_response.body)
      expect(json['error']['message']).to be_eql 'Project name deploymy-codes/api is already taken'
    end
  end
end
