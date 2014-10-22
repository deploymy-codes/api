class User < ActiveRecord::Base

  has_many :accounts, :dependent => :destroy

  validates :first_name, :last_name, :email, presence: true
  validates :email, email: true
  validates :email, uniqueness: { case_sensitive: false }

  def has_github?
    accounts.where(provider: 'github').any?
  end

end
