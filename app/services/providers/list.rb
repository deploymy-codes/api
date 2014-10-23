module Providers
  class List

    def self.call
      self.new.call
    end

    def call
      Account::PROVIDER
    end
  end
end
