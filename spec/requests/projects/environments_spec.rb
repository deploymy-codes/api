require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'List environment' do
  def app
    Endpoint::Projects
  end

  let(:user)     { create_user }
  let!(:project) { create_project name: 'rails', user: user }

  it_behaves_like 'Authenticated', '/rails'
  it_behaves_like 'HasCurrentProject', '/rails'

  it 'returns the list of environment of the project' do
    get "/#{project.name}/environments", {}, { 'API_KEY' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['name']).to be_eql 'default'
    expect(json.first['strategy']).to be_eql ''
  end
end
