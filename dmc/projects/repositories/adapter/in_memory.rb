module Projects
  module Repository
    module Adapter
      class InMemory < ::Repository::Adapter::InMemory

        def query_project_with_user_id(klass, selector)
          all(klass).select { |project| project.user_id == selector.user_id }
        end

        def query_project_with_name_and_user_id(klass, selector)
          all(klass).find do |project|
            project.user_id == selector.user_id && project.name == selector.name
          end
        end

      end
    end
  end
end
