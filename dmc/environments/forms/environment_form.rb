module Environments
  class EnvironmentForm < Form

    attribute :name, String
    attribute :type, String

    validates :name, :type, presence: true
    validates :type, inclusion: { in: Environment::TYPES }

  end
end
