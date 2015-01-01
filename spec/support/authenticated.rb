shared_examples "Authenticated" do |path, method = 'get'|

  context 'When api key is not present' do
    it 'returns a 412' do
      send method, path

      expect(last_response.status).to be_eql 412
    end
  end

  context 'When user corresponding to the api key does not exist' do
    it 'returns a 403' do
      send method, path, {}, { 'API_KEY' => 'random' }

      expect(last_response.status).to be_eql 403
    end
  end

end
