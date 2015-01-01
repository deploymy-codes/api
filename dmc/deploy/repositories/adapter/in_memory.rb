module Deploy
  module Repository
    module Adapter
      class InMemory < ::Repository::Adapter::InMemory

        def query_project_with_user_id(klass, selector)
          all(klass).select { |project| project.user_id = selector.user_id }
        end
      end
    end
  end
end
