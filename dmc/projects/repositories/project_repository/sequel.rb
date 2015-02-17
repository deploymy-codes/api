module Projects
  class ProjectRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_project_with_user_id(klass, selector)
        mapper_for(klass).where(user_id: selector.user_id).to_a
      end

      def query_project_with_name_and_user_id(klass, selector)
        mapper_for(klass).first(user_id: selector.user_id, name: selector.name)
      end

      def clear
        mapper_for(Project).delete
      end
    end
  end
end
