require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Remote organization projects' do
  it_behaves_like 'Authenticated', '/orgs/deploymy-codes/remote_projects'

  def app
    Endpoint::Users
  end

  let!(:user) { create_user }

  it 'lists the available repositories for this organization' do
    get '/orgs/deploymy-codes/remote_projects', {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
  end
end
