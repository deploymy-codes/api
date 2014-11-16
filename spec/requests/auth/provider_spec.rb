require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/auth"

describe 'Auth provider' do

  def app
    Auth
  end

  it 'returns the user corresponding to the code and provider with an api key' do
    get '/github', code: 'code'

    expect(last_response.status).to be_eql 201
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['api_key']).to_not be_nil
  end
end
