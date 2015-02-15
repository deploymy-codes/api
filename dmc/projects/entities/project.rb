module Projects
  class Project < Entity

    attribute :name, String
    attribute :remote_id, Integer
    attribute :url, String
    attribute :user_id, String

    def self.build_from(user: nil, remote_project: nil)
      new.tap do |project|
        project.name      = remote_project.name
        project.remote_id = remote_project.id
        project.url       = remote_project.url
        project.user_id   = user.id
      end
    end

    def dir
      "#{DMC.root}/../tmp/#{id}"
    end

  end
end
