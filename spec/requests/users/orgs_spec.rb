require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Remote projects' do
  it_behaves_like 'Authenticated', '/orgs'

  def app
    Endpoint::Users
  end

  let!(:user) { create_user }

  it 'lists the organisation of this user' do
    get '/orgs', {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array

    expect(json.first['name']).to be_eql 'deploymy-codes'
    expect(json.first['avatar_url']).to include 'avatars'
  end
end
