module Deployments
  class CreateForm < Form

    attribute :commit, String

    validates :commit, presence: true

  end
end
