module Customers
  class RemoteProject < Entity

    attribute :name, String
    attribute :url, String
    attribute :id, Integer
    attribute :imported, Boolean, default: false

  end
end
