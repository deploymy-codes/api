require 'spec_helper'
require_relative "./../../../../web/lib/web"
require_relative "./../../../../web/endpoints/projects"

describe 'Create heroku deployment' do
  def app
    Endpoint::Projects
  end

  let(:user)        { create_user }
  let(:project)     { create_project  user: user }
  let(:environment) { create_environment name: 'master', project: project }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'
  it_behaves_like 'HasCurrentEnvironment'

  context 'when commit exists' do
    it 'returns it' do
      post "/#{project.name}/environments/#{environment.name}/deployments", { deployment: { sha: ENV['GIT_COMMIT_ID'] }}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 201
      json = JSON.parse(last_response.body)
      expect(json).to be_instance_of Hash
      expect(json['sha']).to be_eql ENV['GIT_COMMIT_ID']
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

  context 'when unfinished deployments exist' do
    it 'returns a 409 errors' do
      create_unfinished_deployment environment: environment

      post "/#{project.name}/environments/#{environment.name}/deployments", { deployment: { sha: ENV['GIT_COMMIT_ID'] }}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 409
      json = JSON.parse(last_response.body)
      expect(json['error']['message']).to be_eql 'Environment: master has at least one unfinished deployment'
    end
  end

end
