require 'rails_helper'

RSpec.describe Account do

  it { should validate_presence_of :oauth_token }
  it { should validate_presence_of :user }

  it { should validate_inclusion_of(:provider).in_array(Constants.account.providers.to_hash.values) }

  it { should belong_to :user }

end
