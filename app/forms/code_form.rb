class CodeForm < Form
  attribute :code, String

  class << self
    def from_params(params)
      new params.symbolize_keys.slice(:code)
    end
  end
end
