module Environments
  class RubygemForm < EnvironmentForm
    attribute :rubygem_api_key, String

    validates :rubygem_api_key, presence: true
  end
end
