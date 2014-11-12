require 'json/ext'

class Serializer < Struct.new(:object)

  class << self
    def attributes(*attributes)
      @attributes = attributes
    end
  end

  def as_json
    create_attributes_hash.to_json
  end

  private
  attr_reader :object

  def create_attributes_hash
    self.class.attributes.each_with_object({}) do |hash, attribute|
      hash[attribute] = object.public_send(attribute)
    end
  end
end
