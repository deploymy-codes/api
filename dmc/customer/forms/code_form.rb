module Customer
  class CodeForm < Form

    attribute :code, String

    validates :code, presence: true

    class << self
      def from_params(params)
        new code: params[:code]
      end
    end
  end
end
