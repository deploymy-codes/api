shared_examples "HasCurrentProject" do |path|

  context 'When path is invalid' do
    it 'returns a 404' do
      user = create_user
      get "/invalid", {}, { 'API_KEY' => user.api_key }

      expect(last_response.status).to be_eql 404
    end
  end

end
