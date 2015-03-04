module Environments
  class Environment < Entity

    STRATEGIES       = %w( heroku rubygem )
    DEFAULT_STRATEGY = :heroku
    DEFAULT_NAME     = :default

    attribute :name, String
    attribute :strategy, String
    attribute :project_id, Integer
    attribute :heroku_api_key, String
    attribute :heroku_app_name, String
    attribute :rubygem_api_key, String

  end
end
