module Environments
  class HerokuEnvironment < Environment

    attribute :app_name, String
    attribute :api_key, String

  end
end
