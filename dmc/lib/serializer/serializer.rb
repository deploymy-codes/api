require 'active_support/core_ext/hash'
require 'active_support/core_ext/module'
require 'json/ext'

class Serializer < Struct.new(:object)

  mattr_accessor :attributes

  class << self
    def attributes(*attributes)
      self.attributes = attributes
    end
  end

  def as_json
    hash_object.to_json
  end

  private

  def hash_object
    object.attributes.slice(*attributes)
  end

end
