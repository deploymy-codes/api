module ActiveRecord
  class Account < ActiveRecord::Base

    belongs_to :user, class_name: 'ActiveRecord::User'

  end
end
