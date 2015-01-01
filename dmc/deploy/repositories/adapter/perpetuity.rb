module Deploy
  module Repository
    module Adapter
      class Perpetuity < ::Repository::Adapter::Perpetuity

        def query_project_with_user_id(klass, selector)
          mapper = mapper_for klass
          mapper.select { |project| project.user_id == selector.user_id }.to_a
        end

        def clear
          mapper_for(Deploy::Project).delete_all
        end
      end
    end
  end
end
