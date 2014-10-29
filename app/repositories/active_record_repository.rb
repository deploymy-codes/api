class ActiveRecordRepository

  def build(name, attributes)
    klass(name).new(attributes)
  end

  def find_by(name, attributes)
    klass(name).find_by(attributes)
  end

  def save(object)
    object.save
  end

  def update_attributes_of(object, attributes)
    object.update_attributes attributes
  end

  private

  def klass(name)
    name.to_s.classify.constantize
  end

end
