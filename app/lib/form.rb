require 'virtus'

class Form
  include Virtus.model

  def validate!
    raise ValidationError, errors if !valid?
  end
end
