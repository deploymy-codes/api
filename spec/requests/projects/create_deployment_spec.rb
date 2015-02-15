require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Create deployment' do
  def app
    Endpoint::Projects
  end

  let(:user)        { create_user }
  let(:project)     { create_project name: 'rails', user: user }
  let(:environment) { create_environment name: 'base', project: project }

  it_behaves_like 'Authenticated', '/rails'
  it_behaves_like 'HasCurrentProject'
  it_behaves_like 'HasCurrentEnvironment'

  it 'returns it' do
    post "/#{project.name}/environments/#{environment.name}/deployments", { deployment: { commit: '1hdsajk'}}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 201
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['commit']).to be_eql '1hdsajk'
    expect(json['state']).to be_eql 'pending'
  end
end
