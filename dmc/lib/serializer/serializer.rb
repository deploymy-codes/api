require 'active_support/core_ext/hash'
require 'json/ext'

class Serializer < Struct.new(:object)

  class << self
    def attributes(*attributes)
      @attributes = attributes
    end

    def keys
      @attributes
    end
  end

  def run
    object.attributes.slice(*self.class.keys)
  end

end
