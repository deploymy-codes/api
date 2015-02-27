module Environments
  class CreateForm < Form

    attribute :name, String
    attribute :strategy, String
    attribute :heroku_api_key, String
    attribute :heroku_app_name, String

    validates :name, :strategy, presence: true
    validates :strategy, inclusion: { in: Environment::STRATEGIES }

  end
end
