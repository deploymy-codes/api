class EntityNotFoundError < StandardError

  def initialize(klass, id)
    @klass = klass
    @id    = id
  end

  def message
    "Could not locate #{@klass} with id #{@id}"
  end
end
