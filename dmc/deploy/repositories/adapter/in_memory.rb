module Deploy
  module Repository
    module Adapter
      class InMemory < ::Repository::Adapter::InMemory

        def query_project_with_user_id(klass, selector)
          all(klass).select { |project| project.user_id.to_s == selector.user_id.to_s }
        end

        def query_project_with_name_and_user_id(klass, selector)
          all(klass).find do |project|
            project.user_id.to_s == selector.user_id.to_s && project.name == selector.name
          end
        end

        def query_environments_with_project(klass, selector)
          selector.project.environments
        end
      end
    end
  end
end
