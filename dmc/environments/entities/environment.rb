module Environments
  class Environment < Entity

    STRATEGIES       = %w( heroku )
    DEFAULT_STRATEGY = :heroku
    DEFAULT_NAME     = :default

    attribute :name, String
    attribute :strategy, String
    attribute :project_id, String

  end
end
