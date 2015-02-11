module Environments
  class CreateForm < Form

    attribute :name, String
    attribute :strategy, String

    validates :name, presence: true

  end
end
