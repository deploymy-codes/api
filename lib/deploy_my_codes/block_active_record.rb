module DeployMyCodes

  ActiveRecordNotAvailableError = Class.new(StandardError)

  module BlockActiveRecord

    def save
      no_db_methods
    end

    def save!
      no_db_methods
    end

    def update_attribute(*args)
      no_db_methods
    end

    def update_attribute!(*args)
      no_db_methods
    end

    def update_attributes(*args)
      no_db_methods
    end

    def update_attributes!(*args)
      no_db_methods
    end

    private

    def no_db_methods
      fail ActiveRecordNotAvailableError, "No DB methods on Business Objects"
    end
  end
end
