module Environments
  class TypeNotPresentError < StandardError
  end

  module FactoryForm

    def self.build(hash = {})
      type = hash[:type]
      raise TypeNotPresentError unless type.present?

      "Environments::#{type.classify}Form".constantize.new hash
    end

  end
end
