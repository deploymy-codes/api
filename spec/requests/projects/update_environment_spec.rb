require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Update environment' do
  def app
    Endpoint::Projects
  end

  let(:user)        { create_user }
  let(:project)     { create_project user: user }
  let(:environment) { create_environment project: project }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'
  it_behaves_like 'HasCurrentEnvironment'

  it 'returns the environment updated' do
    put "/#{project.name}/environments/#{environment.name}", {
      environment: {
        name: 'master' ,
        strategy: 'heroku',
        heroku_api_key: 'api_key',
        heroku_app_name: 'app_name'
      }}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['name']).to be_eql 'master'
    expect(json['heroku_api_key']).to be_eql 'api_key'
  end

  context 'When environment name is already taken' do
    it 'returns a 403 error' do
      create_environment project: project, name: 'new_master'

      put "/#{project.name}/environments/#{environment.name}", {
        environment: {
          name: 'new_master' ,
          strategy: 'heroku',
          heroku_api_key: 'api_key',
          heroku_app_name: 'app_name'
        }}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 403
      json = JSON.parse(last_response.body)
      expect(json['error']['message']).to be_eql 'Environment name new_master is already taken'
    end
  end
end
