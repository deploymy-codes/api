module Customer
  class CodeForm < Form
    attribute :code, String

    class << self
      def from_params(params)
        new code: params[:code]
      end
    end
  end
end
