module Environments
  class Environment < Entity

    STRATEGIES       = %w( heroku rubygem )
    DEFAULT_STRATEGY = :heroku
    DEFAULT_NAME     = :default

    attribute :name, String
    attribute :project_id, Integer

  end
end
