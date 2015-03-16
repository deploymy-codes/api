module Projects
  class RepositoryForm < Form

    attribute :id, Integer

    validates :id, presence: true

  end
end
