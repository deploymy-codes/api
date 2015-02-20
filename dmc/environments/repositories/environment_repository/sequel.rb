module Environments
  class EnvironmentRepository
    class Sequel < ::Repository::Adapter::Sequel

      def query_environment_with_project_id(klass, selector)
        mapper_for(klass).where(project_id: selector.project_id).to_a
      end

      def query_environment_with_name_and_project_id(klass, selector)
        mapper_for(klass).first(project_id: selector.project_id, name: selector.name)
      end

      def query_paginate_environment_with_project_id(klass, selector)
        mapper_for(klass).where(project_id: selector.project_id).limit(selector.limit).offset(selector.offset).to_a
      end

      def query_count_environment_with_project_id(klass, selector)
        mapper_for(klass).where(project_id: selector.project_id).count
      end

      def clear
        mapper_for(Environment).delete
      end

    end
  end
end
