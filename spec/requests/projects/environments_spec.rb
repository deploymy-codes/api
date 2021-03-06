require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'List environment' do
  def app
    Endpoint::Projects
  end

  let(:user)         { create_user }
  let(:project)      { create_project user: user }
  let!(:environment) { create_environment project: project }

  it_behaves_like 'Authenticated', '/rails/rails/environments'
  it_behaves_like 'HasCurrentProject'

  it 'returns the list of environment of the project' do
    get "/#{project.name}/environments", {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['name']).to be_eql 'master'
    expect(json.first['type']).to be_eql 'heroku'

    expect(last_response).to be_paginated
  end
end
