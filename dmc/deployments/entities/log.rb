module Deployments
  class Log < Entity

    attribute :deployment_id, Integer
    attribute :name, String
    attribute :stdout, String
    attribute :duration, Integer

  end
end
