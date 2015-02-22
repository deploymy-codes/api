require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'List commit' do
  def app
    Endpoint::Projects
  end

  let(:user)     { create_user }
  let!(:project) { create_project user: user }

  it_behaves_like 'Authenticated', '/rails/rails/commits'
  it_behaves_like 'HasCurrentProject'

  it 'returns the list of commits of the project' do
    get "/#{project.name}/commits", {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['id']).to_not be_empty

    expect(last_response).to be_paginated
  end
end
