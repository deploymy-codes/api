class Cursor

  MAX_LIMIT = 100

  attr_accessor :data, :total_count

  def initialize(offset = nil, limit = nil)
    @offset = offset
    @limit  = limit
    @data   = []
    @total_count  = 0
  end

  def offset
    @offset || 0
  end

  def limit
    return MAX_LIMIT if @limit.blank? || @limit > MAX_LIMIT

    @limit
  end

  def options
    [offset, limit]
  end
end
