module Environments
  class RubygemEnvironmentSerializer < Serializer
    attributes :name, :type, :api_key
  end
end
