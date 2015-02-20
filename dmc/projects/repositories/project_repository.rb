module Projects
  class ProjectRepository < Repository

    class UnknownNameError < StandardError
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
        raise UnknownNameError, name if project.nil?

        project
      end

      def paginate_for_user!(user_id, cursor)
        query Project, PaginateProjectWithUserId.new(user_id, cursor.limit, cursor.offset)
      end

      def count_for_user!(user_id)
        query Project, CountProjectWithUserId.new(user_id)
      end
    end

  end

  ProjectWithUserId          = Struct.new :user_id
  CountProjectWithUserId     = Struct.new :user_id
  PaginateProjectWithUserId  = Struct.new :user_id, :limit, :offset
  ProjectWithNameAndUserId   = Struct.new :name, :user_id
end
