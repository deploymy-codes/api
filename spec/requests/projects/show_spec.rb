require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Show' do
  def app
    Endpoint::Projects
  end

  let(:user)    { create_user }
  let(:project) { create_project name: 'rails', user: user }

  it_behaves_like 'Authenticated', '/rails'
  it_behaves_like 'HasCurrentProject', '/rails'

  it 'returns it' do
    get "/#{project.name}", {}, { 'API_KEY' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['name']).to be_eql project.name
    expect(json['remote_name']).to be_eql project.remote_name
    expect(json['url']).to be_eql project.url
  end
end
