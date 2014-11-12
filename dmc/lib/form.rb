require 'virtus'

class Form
  include Virtus.model

  def initialize(hash = {})
    assert_valid_keys! hash
    super
  end

  def validate!
    #raise ValidationError, errors if !valid?
  end

  private

  def assert_valid_keys!(hash)
    return if attributes.empty?

    hash.keys.each do |key|
      raise UnknownFormFieldError, key unless attribute_keys.include? key.to_sym
    end
  end

  def attribute_keys
    attributes.keys
  end

end
