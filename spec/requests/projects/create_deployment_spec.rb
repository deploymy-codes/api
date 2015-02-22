require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Create deployment' do
  def app
    Endpoint::Projects
  end

  let(:user)        { create_user }
  let(:project)     { create_project  user: user }
  let(:environment) { create_environment name: 'base', project: project }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'
  it_behaves_like 'HasCurrentEnvironment'

  context 'when commit exists' do
    it 'returns it' do
      post "/#{project.name}/environments/#{environment.name}/deployments", { deployment: { sha: '3b23ae0' }}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 201
      json = JSON.parse(last_response.body)
      expect(json).to be_instance_of Hash
      expect(json['sha']).to be_eql '3b23ae0'
      expect(json['state']).to be_eql 'pending'
    end
  end

  context 'when commit does not exist' do
    it 'returns it returns a 403 error' do
      post "/#{project.name}/environments/#{environment.name}/deployments", { deployment: { sha: 'bad_sha' }}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 403
      json = JSON.parse(last_response.body)
      expect(json['error']['message']).to be_eql 'Commit bad_sha does not exist'
    end
  end

end
