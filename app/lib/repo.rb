class Repo
  include Facade

  def find(klass, id)
    raise ArgumentError, "id cannot be nil!" if id.nil?
    super
  end

  def save(record)
    if record.id
      update record
    else
      create record
    end
  end

end
