module Environments
  class EnvironmentRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_environment_with_project_id(klass, selector)
        all(klass).select { |environment| environment.project_id == selector.project_id }
      end

      def query_environment_with_name_and_project_id(klass, selector)
        all(klass).find { |environment| environment.project_id == selector.project_id && environment.name == selector.name }
      end

      def query_paginate_environment_with_project_id(klass, selector)
        query_environment_with_project_id(klass, selector).slice(selector.offset, selector.limit)
      end

      def query_count_environment_with_project_id(klass, selector)
        query_environment_with_project_id(klass, selector).length
      end

    end
  end
end
