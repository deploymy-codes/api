require 'spec_helper'
require_relative "./../../../../web/lib/web"
require_relative "./../../../../web/endpoints/projects"

describe 'Create rubygem deployment' do
  def app
    Endpoint::Projects
  end

  let(:user)        { create_user }
  let(:project)     { create_project full_name: 'deploymy-codes/deploymycodes-gem', remote_url: 'https://github.com/deploymy-codes/deploymycodes-gem.git', remote_id: 31734830, user: user }
  let(:environment) { create_environment strategy: 'rubygem', name: 'master', project: project }

  it_behaves_like 'Authenticated', '/rails/rails'
  it_behaves_like 'HasCurrentProject'
  it_behaves_like 'HasCurrentEnvironment'

  context 'when commit exists' do
    it 'returns it' do
      post "/#{project.name}/environments/#{environment.name}/deployments", { deployment: { sha: ENV['GIT_GEM_COMMIT_ID'] }}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 201
      json = JSON.parse(last_response.body)
      expect(json).to be_instance_of Hash
      expect(json['sha']).to be_eql ENV['GIT_GEM_COMMIT_ID']
    end
  end
end
