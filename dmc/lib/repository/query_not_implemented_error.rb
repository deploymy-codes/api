class QueryNotImplementedError < StandardError

  def initialize(selector)
    @selector = selector
  end

  def message
    "Adapter does not support #{@selector.class}!"
  end

end
