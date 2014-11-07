class Account
  include Chassis::Persistence

  attr_accessor :oauth_token, :user
end
