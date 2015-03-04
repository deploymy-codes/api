module Environments
  class EnvironmentForm < Form

    attribute :name, String
    attribute :strategy, String

    validates :name, :strategy, presence: true
    validates :strategy, inclusion: { in: Environment::STRATEGIES }

    #TODO: Build form per strategy
    attribute :heroku_api_key, String
    attribute :heroku_app_name, String

    validates :heroku_app_name, :heroku_api_key, presence: true
  end
end
