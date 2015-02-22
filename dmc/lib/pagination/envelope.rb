class Envelope < Struct.new(:data, :total_count, :cursor)

  delegate :limit, :offset, to: :cursor

  def next_offset
    limit + offset
  end

  def next_offset?
    next_offset <= total_count
  end

  def previous_offset
    offset - limit
  end

  def previous_offset?
    previous_offset >= 0
  end

  def first?
    offset == 0
  end

  def last_offset
    total_count - limit
  end

  def last?
    last_offset == offset
  end

end
