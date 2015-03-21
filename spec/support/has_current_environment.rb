shared_examples "HasCurrentEnvironment" do

  context 'When path is invalid' do
    it 'returns a 404' do
      user    = create_user
      create_project full_name: 'deploymycodes/frontend', user: user
      get "/rails/default", {}, { 'HTTP_AUTHORIZATION' => user.api_key }

      expect(last_response.status).to be_eql 404
    end
  end

end
