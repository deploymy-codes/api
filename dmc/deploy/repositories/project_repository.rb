module Deploy
  class ProjectRepository < Repository

    class << self
      def all_for_user!(user_id)
        query Project, ProjectWithUserId.new(user_id)
      end
    end

  end

  ProjectWithUserId = Struct.new :user_id
end
