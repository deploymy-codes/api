module Deploy
  class EnvironmentSerializer < Serializer
    attributes :name, :strategy
  end
end
