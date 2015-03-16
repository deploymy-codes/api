module Environments
  class HerokuStrategy < Strategy

    attribute :heroku_api_key, String
    attribute :heroku_app_name, String

  end
end
