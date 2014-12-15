module ActiveRecord
  class User < ActiveRecord::Base

    has_many :accounts, dependent: :destroy, class_name: 'ActiveRecord::Account'
    has_many :projects, dependent: :destroy, class_name: 'ActiveRecord::Project'

  end
end
