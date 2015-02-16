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
    expect(json.first['oid']).to be_eql 'a8955f57f76d1b77d1e7a61911f1da369863817e'
  end
end
