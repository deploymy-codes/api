module Deploy
  class ProjectRepository < Repository

    class UnknownProjectNameError < StandardError
      def initialize(name)
        @name = name
      end

      def to_s
        "Could not find the project with name: #{@name}"
      end
    end

    class << self
      def all_for_user!(user_id)
        query Project, ProjectWithUserId.new(user_id)
      end

      def find_by_name_and_user_id!(name, user_id)
        project = query Project, ProjectWithNameAndUserId.new(name, user_id)
        raise UnknownProjectNameError, name if project.nil?

        project
      end

      def all_environments_of!(project)
        query Project, EnvironmentsWithProject.new(project)
      end
    end

  end

  ProjectWithUserId        = Struct.new :user_id
  ProjectWithNameAndUserId = Struct.new :name, :user_id
  EnvironmentsWithProject  = Struct.new :project
end
