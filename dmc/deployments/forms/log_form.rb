module Deployments
  class LogForm < Form

    attribute :name, String
    attribute :stdout, String
    attribute :duration, Integer

    validates :name, presence: true

  end
end
