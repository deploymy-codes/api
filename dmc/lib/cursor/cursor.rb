class Cursor

  MAX_LIMIT = 100
  MIN_LINIT = 1

  attr_reader :offset

  def initialize(offset = nil, limit = nil)
    @offset = offset.to_i
    @limit  = limit.to_i
  end

  def limit
    return MAX_LIMIT unless (MIN_LINIT..MAX_LIMIT).include?(@limit)

    @limit
  end
end
