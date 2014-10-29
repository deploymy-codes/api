class User < ActiveRecord::Base

  validates :email, :first_name, :last_name, presence: true

  has_many :accounts, dependent: :destroy

end
