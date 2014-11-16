class RecordNotFoundError < StandardError

  def initialize(klass, id)
    @klass = klass
    @id    = id
  end

  def to_s
    "Could not locate #{@klass} with id #{@id}"
  end
end
