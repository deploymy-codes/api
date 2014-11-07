class CodeForm < Form
  attribute :code, String

  validates :code, presence: true

  class << self
    def from_params(params)
      new params.symbolize_keys.slice(:code)
    end
  end
end
