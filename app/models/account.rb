class Account < ActiveRecord::Base
  include Biz::Account

  validates :oauth_token, :user, presence: true
  validates :provider, inclusion: { in: Constants.account.providers.to_hash.values }

  belongs_to :user

end
