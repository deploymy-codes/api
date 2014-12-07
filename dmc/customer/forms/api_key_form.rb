module Customer
  class APIKeyForm < Form

    attribute :api_key, String

    validates :api_key, presence: true

    class << self
      def from_params(params)
        new api_key: params[:api_key]
      end
    end
  end
end
