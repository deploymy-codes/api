require 'virtus'

class Entity

  attr_accessor :id

  def persisted?
    id.present?
  end

  def initialize(attributes = {})
    attributes.each do |key, value|
      send "#{key}=", value
    end
  end

  def attributes
    Hash[instance_variables.map { |var| [var[1..-1].to_sym, instance_variable_get(var)] }]
  end

end
