module Environments
  class CreateForm < Form

    attribute :name, String
    attribute :strategy, String

    validates :name, :strategy, presence: true
    validates :strategy, inclusion: { in: Environment::STRATEGIES }

  end
end
