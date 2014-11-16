class ApiKeyHeaderMissingError < StandardError
  def to_s
    "API-KEY header missing"
  end
end
