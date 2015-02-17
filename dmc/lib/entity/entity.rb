require 'virtus'

class Entity
  include Virtus.model

  attribute :id, Integer

  def persisted?
    id.present?
  end

end
