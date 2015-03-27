module Environments
  class HerokuEnvironmentSerializer < Serializer
    attributes :name, :type, :api_key, :app_name
  end
end
