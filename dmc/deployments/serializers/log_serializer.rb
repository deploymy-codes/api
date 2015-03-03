module Deployments
  class LogSerializer < Serializer
    attributes :id, :duration, :stdout, :name
  end
end
