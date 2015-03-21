module Environments
  class Environment < Entity

    TYPES = %w(heroku rubygem)

    attribute :name, String
    attribute :type, String
    attribute :project_id, Integer

  end
end
