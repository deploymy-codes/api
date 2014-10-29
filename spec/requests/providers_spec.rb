require 'rails_helper'

RSpec.describe 'Providers' do

  describe '#index' do
    it 'lists all providers' do
      get 'providers'

      json = JSON.parse(response.body)
      expect(json.length).to eq(2)
      expect(json['github']).to eq(Constants.account.providers.github)
      expect(json['bitbucket']).to eq(Constants.account.providers.bitbucket)
    end
  end

  describe '#show' do
    it 'shows all projects for one provider'
  end
end