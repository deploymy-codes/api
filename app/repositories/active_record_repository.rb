class ActiveRecordRepository

  def build(name, params)
    klass(name).new params
  end

  def find_by(name, params, associations: [])
    ::DeployMyCodes::Biz.wrap klass(name).includes(associations).find_by(params), associations
  end

  def save(object)
    object.data.save
  end

  def update_attributes_of(object, params)
    object.data.update_attributes params
  end

  private

  def klass(name)
    name.to_s.classify.constantize
  end

end
