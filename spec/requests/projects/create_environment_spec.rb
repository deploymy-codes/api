require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Create environment' do
  def app
    Projects
  end

  let(:user)    { create_user }
  let(:project) { create_project name: 'rails', user: user }

  it_behaves_like 'Authenticated', '/rails'
  it_behaves_like 'HasCurrentProject', '/rails'

  it 'returns the new environment' do
    post "/#{project.name}/environments", { environment: { name: 'master' , strategy: 'heroku'}}, { 'API_KEY' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['name']).to be_eql 'master'
    expect(json['strategy']).to be_eql 'heroku'
  end
end
