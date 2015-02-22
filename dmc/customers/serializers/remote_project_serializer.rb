module Customers
  class RemoteProjectSerializer < Serializer
    attributes :full_name, :owner, :name, :url, :imported
  end
end
