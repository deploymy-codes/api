module Environments
  class NameTakenError < StandardError
    def initialize(name)
      @name = name
    end

    def message
      "Environment name #{@name} is already taken"
    end
  end
end
