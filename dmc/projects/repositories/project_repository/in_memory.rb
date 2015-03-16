module Projects
  class ProjectRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_project_with_user_id(klass, selector)
        all(klass).select { |project| project.user_id == selector.user_id }
      end

      def query_project_with_remote_id(klass, selector)
        all(klass).find { |project| project.remote_id == selector.remote_id }
      end

      def query_project_with_name_and_user_id(klass, selector)
        all(klass).find do |project|
          project.user_id == selector.user_id && project.name == selector.name
        end
      end

      def query_paginate_project_with_user_id(klass, selector)
        query_project_with_user_id(klass, selector).slice(selector.offset, selector.limit)
      end

      def query_count_project_with_user_id(klass, selector)
        query_project_with_user_id(klass, selector).length
      end

    end
  end
end
