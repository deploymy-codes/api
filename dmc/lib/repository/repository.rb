require 'interchange'

require_relative './query_not_implemented_error'
require_relative './entity_not_found_error'
require_relative './adapter/in_memory'
require_relative './adapter/sequel'

class Repository
  extend Interchange.new(*[
    :all, :find, :create, :update, :delete,
    :first, :last, :query, :sample, :empty?,
    :count, :clear,
  ])

  class << self

    def find(klass, id)
      raise ArgumentError, "id cannot be nil!" if id.nil?
      super
    end

    def save(record)
      if record.persisted?
        update record
      else
        create record
      end
    end

  end

end
