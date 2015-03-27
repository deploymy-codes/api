module Environments
  class RubygemForm < EnvironmentForm
    attribute :api_key, String

    validates :api_key, presence: true
  end
end
