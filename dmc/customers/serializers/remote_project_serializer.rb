module Customers
  class RemoteProjectSerializer < Serializer
    attributes :name, :url, :imported
  end
end
