class ActiveRecordRepository

  def build(name, params)
    klass(name).new params
  end

  def find_by(name, params)
    klass(name).find_by params
  end

  def save(object)
    object.save
  end

  def update_attributes_of(object, params)
    object.update_attributes params
  end

  private

  def klass(name)
    name.to_s.classify.constantize
  end

end
