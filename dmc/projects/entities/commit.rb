module Projects
  class Commit
    include Virtus.model

    attribute :oid, String
  end
end
