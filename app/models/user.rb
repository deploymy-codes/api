class User < ActiveRecord::Base

  has_many :accounts, :dependent => :destroy

  validates :first_name, :last_name, :email, presence: true
  validates :email, email: true
  validates :email, uniqueness: { case_sensitive: false }

  delegate :github, :bitbucket, to: :accounts

  def github?
    github.any?
  end

  def bitbucket?
    bitbucket.any?
  end

end
