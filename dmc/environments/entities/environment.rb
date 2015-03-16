module Environments
  class Environment < Entity

    STRATEGIES = %w(heroku rubygem)

    attribute :name, String
    attribute :strategy, String
    attribute :project_id, Integer

  end
end
