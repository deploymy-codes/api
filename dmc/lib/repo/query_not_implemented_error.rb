class QueryNotImplementedError < StandardError

  def initialize(selector)
    @selector = selector
  end

  def to_s
    "Adapter does not support #{@selector.class}!"
  end

end
