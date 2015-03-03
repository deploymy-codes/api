require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/streams"

describe 'Deployment' do
  def app
    Endpoint::Streams
  end

  let(:user)        { create_user }
  let(:project)     { create_project user: user }
  let(:environment) { create_environment project: project }
  let(:deployment)  { create_deployment environment: environment }

  it 'returns the logs' do
    get "/#{project.name}/environments/#{environment.name}/deployments/#{deployment.id}", {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['logs'].first['name']).to include 'Check access on'
  end
end
