module Environments
  class HerokuForm < EnvironmentForm
    attribute :api_key, String
    attribute :app_name, String

    validates :app_name, :api_key, presence: true
  end
end
