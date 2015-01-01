require 'virtus'

class Entity
  include Virtus.model

  attribute :id

  def persisted?
    id.present?
  end
end
