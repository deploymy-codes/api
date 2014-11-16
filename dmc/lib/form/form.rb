require 'virtus'
require 'active_model'

require_relative './validation_error'
require_relative './unknown_form_field_error'
require_relative './permission_denied_error'

class Form
  include Virtus.model
  include ActiveModel::Validations

  def initialize(hash = {})
    assert_valid_keys! hash
    super
  end

  def validate!
    raise ValidationError, errors if !valid?
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
