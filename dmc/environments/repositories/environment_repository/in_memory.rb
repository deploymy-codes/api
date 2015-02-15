module Environments
  class EnvironmentRepository
    class InMemory < ::Repository::Adapter::InMemory

      def query_environment_with_project_id(klass, selector)
        all(klass).select { |environment| environment.project_id == selector.project_id }
      end

      def query_environment_with_name_and_project_id(klass, selector)
        all(klass).find { |environment| environment.project_id == selector.project_id && environment.name == selector.name }
      end
    end

  end
end
