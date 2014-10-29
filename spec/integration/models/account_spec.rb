require 'rails_helper'

RSpec.describe Account do

  it { should belong_to :user }

end
