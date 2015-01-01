module Deploy
  class Project < Entity

    attr_accessor :name, :remote_name, :url, :user_id

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
