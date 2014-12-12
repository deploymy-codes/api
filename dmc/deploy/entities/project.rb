module Deploy
  class Project < Entity

    attribute :name, String
    attribute :remote_name, String
    attribute :url, String
    attribute :user_id, Integer

    def self.build_from(user: nil, remote_project: nil)
      new.tap do |project|
        project.name        = remote_project.name
        project.remote_name = remote_project.name
        project.url         = remote_project.url
        project.user_id     = user.id
      end
    end

  end
end
