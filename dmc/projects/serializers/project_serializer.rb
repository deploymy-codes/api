module Projects
  class ProjectSerializer < Serializer
    attributes :name, :remote_id, :url
  end
end
