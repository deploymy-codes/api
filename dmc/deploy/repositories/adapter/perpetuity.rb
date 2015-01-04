module Deploy
  module Repository
    module Adapter
      class Perpetuity < ::Repository::Adapter::Perpetuity

        def query_project_with_user_id(klass, selector)
          mapper = mapper_for klass
          mapper.select { |project| project.user_id == selector.user_id }.to_a
        end

        def query_project_with_name_and_user_id(klass, selector)
          mapper_for(klass).find do |project|
            project.user_id == selector.user_id && project.name == selector.name
          end
        end

        def clear
          mapper_for(Deploy::Project).delete_all
        end
      end
    end
  end
end
