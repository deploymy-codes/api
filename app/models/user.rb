class User
  include Chassis::Persistence

  def read_attribute_for_serialization(name)
    value = send name

    case value
    when Time then value.utc.iso8601
    else value
    end
  end

  attr_accessor :name, :email, :api_key, :accounts
end
