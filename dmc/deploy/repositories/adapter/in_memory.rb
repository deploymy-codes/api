module Deploy
  module Repository
    module Adapter
      class InMemory < ::Repository::Adapter::InMemory

        def query_environment_with_name_and_project_id(klass, selector)
          project = all(Project).find { |project| project.id == selector.project_id }
          return if project.nil?

          project.environments.find { |environment| environment.name == selector.name }
        end

        def query_project_with_user_id(klass, selector)
          all(klass).select { |project| project.user_id == selector.user_id }
        end

        def query_project_with_name_and_user_id(klass, selector)
          all(klass).find do |project|
            project.user_id == selector.user_id && project.name == selector.name
          end
        end

        def query_environments_with_project(klass, selector)
          selector.project.environments
        end
      end
    end
  end
end
