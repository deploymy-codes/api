class Account < ActiveRecord::Base

  belongs_to :user

  validates :provider, inclusion: { in: Constants.account.providers}

  scope :github, -> { where(provider: Constants.account.providers.github) }
  scope :bitbucket, -> { where(provider: Constants.account.providers.bitbucket) }

end
