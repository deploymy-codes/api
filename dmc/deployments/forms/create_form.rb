module Deployments
  class CreateForm < Form

    attribute :sha, String

    validates :sha, presence: true

  end
end
