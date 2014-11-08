class Serializer < Struct.new(:object)

  class << self
    def attributes(*attributes)
      @attributes = attributes
    end
  end

  def serialize
    create_attributes_hash
  end

  private
  attr_reader :object

  def create_attributes_hash
    self.class.attributes.object_with_index({}) do |hash, attribute|
      hash[attribute] = object.public_send(attribute)
    end
  end
end
