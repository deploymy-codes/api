require 'active_support/core_ext/hash'

class Serializer < Struct.new(:object)

  class << self
    def attributes(*attributes)
      @attributes = attributes
    end
  end

  def as_json
    hash_object.to_json
  end

  private
  attr_reader :object

  def hash_object
    object.attributes.slice(@attributes)
  end

end
