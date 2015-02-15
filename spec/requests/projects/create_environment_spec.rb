require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Create environment' do
  def app
    Endpoint::Projects
  end

  let(:user)    { create_user }
  let(:project) { create_project user: user }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'

  it 'returns the new environment' do
    post "/#{project.name}/environments", { environment: { name: 'master' , strategy: 'heroku'}}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['name']).to be_eql 'master'
    expect(json['strategy']).to be_eql 'heroku'
  end

  context 'When environment name is already taken' do
    it 'returns a 403 errors' do
      post "/#{project.name}/environments", { environment: { name: 'master' , strategy: 'heroku'}}, { 'HTTP_AUTHORIZATION' => user.api_key }

      post "/#{project.name}/environments", { environment: { name: 'master' , strategy: 'heroku'}}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 403
      json = JSON.parse(last_response.body)
      expect(json['error']['message']).to be_eql 'Environment name master is already taken'
    end
  end
end
