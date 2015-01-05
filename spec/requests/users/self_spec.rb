require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/users"

describe 'Self' do
  it_behaves_like 'Authenticated', '/self'

  def app
    Users
  end

  let!(:user) { create_user }

  it 'returns it' do
    get '/self', {}, { 'API_KEY' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['api_key']).to be_eql user.api_key
  end
end
