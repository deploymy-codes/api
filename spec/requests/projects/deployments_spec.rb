require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'List deployment' do
  def app
    Endpoint::Projects
  end

  let(:user)        { create_user }
  let(:project)     { create_project user: user }
  let(:environment) { create_environment name: 'master', project: project }
  let!(:deployment) { create_deployment environment: environment }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'
  it_behaves_like 'HasCurrentEnvironment'

  it 'returns the list of deployments of the project' do
    get "/#{project.name}/environments/#{environment.name}/deployments", {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['sha']).to be_eql ENV['GIT_COMMIT_ID']

    expect(last_response).to be_paginated
  end

end
