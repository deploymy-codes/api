module Deployments
  class Deployment < Entity

    attribute :commit, String
    attribute :environment_id, String
    attribute :log, String
    attribute :state, String

    def self.build(commit, environment_id)
      new.tap do |deployment|
        deployment.environment_id = environment_id
        deployment.commit         = commit
        deployment.state          = DEFAULT_STATE
      end
    end

  end
end
