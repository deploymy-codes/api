class Account < ActiveRecord::Base

  belongs_to :user

  PROVIDER = %w(github bitbucket)

  validates :provider, inclusion: { in: PROVIDER }

  scope :github, -> { where(provider: 'github') }
  scope :bitbucket, -> { where(provider: 'bitbucket') }

end
