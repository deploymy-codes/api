require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Root' do
  it_behaves_like 'Authenticated', '/'

  def app
    Projects
  end

  let(:user) { create_user }

  let(:remote_project) { Customer::RemoteProject.new(name: 'rails', url: 'http://www.google.com') }

  let!(:project) { Deploy::CreateProject.new(user, remote_project).run! }

  it 'returns the list of projects associated to this user' do
    get '/', {}, { 'API_KEY' => user.api_key }

    expect(last_response.status).to be_eql 200
    json = JSON.parse(last_response.body)
    expect(json).to be_instance_of Array
    expect(json.first['name']).to be_eql 'rails'
    expect(json.first['remote_name']).to be_eql 'rails'
    expect(json.first['url']).to be_eql 'http://www.google.com'
  end
end
