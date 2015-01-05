require 'virtus'

class Entity
  include Virtus.model

  attr_reader :id

  def persisted?
    id.present?
  end

end
