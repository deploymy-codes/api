require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'List branch' do
  def app
    Endpoint::Projects
  end

  let(:user)     { create_user }
  let!(:project) { create_project user: user }

  it_behaves_like 'Authenticated', '/rails/rails/tags'
  it_behaves_like 'HasCurrentProject'

  it 'returns the list of environment of the project' do
    get "/#{project.name}/tags", {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['name']).to be_eql 'v-0.0.0'
  end
end
