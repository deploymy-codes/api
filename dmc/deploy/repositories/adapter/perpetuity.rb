module Deploy
  module Repository
    module Adapter
      class Perpetuity < ::Repository::Adapter::Perpetuity

        def clear
          mapper_for(Deploy::Project).delete_all
        end
      end
    end
  end
end
