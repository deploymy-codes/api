module Environments
  class EnvironmentSerializer < Serializer
    attributes :name, :strategy, :heroku_api_key, :heroku_app_name
  end
end
