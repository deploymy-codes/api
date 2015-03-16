module Environments
  class RubygemEnvironmentSerializer < Serializer
    attributes :name, :strategy, :api_key
  end
end
