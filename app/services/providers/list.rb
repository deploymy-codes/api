module Providers
  class List

    def self.call
      self.new.call
    end

    def call
      ['github']
    end
  end
end
