module Environments
  class EnvironmentRepository
    class Perpetuity < ::Repository::Adapter::Perpetuity

      def query_environment_with_project_id(klass, selector)
        mapper_for(klass).select { |environment| environment.project_id == selector.project_id }.to_a
      end

      def query_environment_with_name_and_project_id(klass, selector)
        mapper_for(klass).find { |environment| environment.project_id == selector.project_id && environment.name == selector.name }
      end

      def clear
        mapper_for(Environment).delete_all
      end

    end
  end
end
