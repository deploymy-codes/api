class Pager

  def initialize(offset = nil, limit = nil)
    @offset = offset
    @limit  = limit
  end

  def offset
    @offset || 0
  end

  def limit
    @limit || 100
  end

  def options
    [offset, limit]
  end
end
