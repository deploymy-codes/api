module Deployments
  class Deployment < Entity
    STATE            = [:pending, :in_progress, :succeeded, :failed]
    DEFAULT_STATE    = :pending
    UNFINISHED_STATE = [:pending, :in_progress]

    attribute :sha, String
    attribute :environment_id, Integer
    attribute :state, String
    attribute :release, String

    def self.build(sha, environment_id)
      new.tap do |deployment|
        deployment.environment_id = environment_id
        deployment.sha            = sha
        deployment.state          = DEFAULT_STATE
      end
    end

  end
end
