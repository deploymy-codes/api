require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Root' do
  it_behaves_like 'Authenticated', '/'

  def app
    Endpoint::Projects
  end

  let(:user) { create_user }

  let(:remote_project) do
    Customers::RemoteProject.new(name:'deploymy-codes/api', url: 'https://github.com/deploymy-codes/api.git', id: 25465783)
  end

  let!(:project) { Projects::Create.new(user, remote_project).run! }

  it 'returns the list of projects associated to this user' do
    get '/', {}, { 'HTTP_AUTHORIZATION' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['name']).to be_eql 'deploymy-codes/api'
    expect(json.first['remote_id']).to be_eql 25465783
    expect(json.first['url']).to be_eql 'https://github.com/deploymy-codes/api.git'
  end
end
