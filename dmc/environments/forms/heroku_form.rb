module Environments
  class HerokuForm < EnvironmentForm
    attribute :heroku_api_key, String
    attribute :heroku_app_name, String

    validates :heroku_app_name, :heroku_api_key, presence: true
  end
end
