require 'rails_helper'

RSpec.describe 'Providers' do

  describe '#index' do
    it 'lists all providers' do
      get 'providers'

      expect(response).to be_success
      json = JSON.parse(response.body)
      expect(json['messages'].length).to eq(10)
    end
  end

end
