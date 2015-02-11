module Projects
  class ProjectSerializer < Serializer
    attributes :name, :remote_name, :url
  end
end
