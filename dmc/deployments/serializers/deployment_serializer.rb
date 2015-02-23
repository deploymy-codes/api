module Deployments
  class DeploymentSerializer < Serializer
    attributes :sha, :log, :state
  end
end
