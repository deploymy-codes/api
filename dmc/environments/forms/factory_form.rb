module Environments
  module FactoryForm

    def self.build(hash = {})
      strategy = hash[:strategy]

      "Environments::#{strategy.classify}Form".constantize.new hash
    end

  end
end
