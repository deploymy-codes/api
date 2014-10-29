class Account < ActiveRecord::Base
  include Biz::Account

  belongs_to :user

end
