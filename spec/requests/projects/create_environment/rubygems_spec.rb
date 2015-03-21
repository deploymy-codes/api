require 'spec_helper'
require_relative "./../../../../web/lib/web"
require_relative "./../../../../web/endpoints/projects"

describe 'Create rubygems environment' do
  def app
    Endpoint::Projects
  end

  let(:user)    { create_user }
  let(:project) { create_project user: user }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'

  it 'returns the new environment' do
    post "/#{project.name}/environments", { environment: {
      name: 'master',
      type: 'rubygem',
      api_key: 'rubygem_api_key',
    }}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 201
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Hash
    expect(json['name']).to be_eql 'master'
    expect(json['type']).to be_eql 'rubygem'
  end

end
