require 'spec_helper'
require_relative "./../../../web/lib/web"
require_relative "./../../../web/endpoints/webhook"

describe 'Webhook provider' do
  def app
    Endpoint::Webhook
  end

  let(:user)    { create_user }
  let(:project) { create_project user: user }

  it 'return nothing' do
    post('/github', repository: {
      id: project.remote_id,
      name: "api",
      full_name: project.name,
      owner: {
        name: "deploymy-codes",
        email: "coders@deploymy.codes"
      },
      private: false,
      description: "",
      fork: false
    })

    expect(last_response.status).to be_eql 200
    expect(last_response.body).to be_eql ''
  end
end
