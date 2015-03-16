module Environments
  class HerokuEnvironmentSerializer < Serializer
    attributes :name, :strategy, :api_key, :app_name
  end
end
