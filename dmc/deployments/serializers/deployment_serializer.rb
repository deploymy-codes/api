module Deployments
  class DeploymentSerializer < Serializer
    attributes :commit, :log, :state
  end
end
