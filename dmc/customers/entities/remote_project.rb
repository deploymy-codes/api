module Customers
  class RemoteProject < Entity

    attribute :full_name, String
    attribute :owner, String
    attribute :name, String
    attribute :url, String
    attribute :id, Integer
    attribute :imported, Boolean, default: false

  end
end
