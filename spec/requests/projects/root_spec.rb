require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/projects"

describe 'Root' do

  def app
    Projects
  end

  context 'When api key is not present' do
    it 'returns a 412' do
      get '/'

      expect(last_response.status).to be_eql 412
    end
  end

  context 'When user corresponding to the api key does not exist' do
    it 'returns a 403' do
      get '/', {}, { 'API_KEY' => 'random' }

      expect(last_response.status).to be_eql 403
    end
  end

  context 'When user is found' do
    let(:user) do
      code_form = Customer::CodeForm.new code: 'code'
      Customer::FindOrCreateUser.new('github', code_form).run!
    end

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
end
