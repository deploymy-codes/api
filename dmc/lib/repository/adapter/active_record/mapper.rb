class Repository
  module Adapter
    class ActiveRecord
      module Mapper
        class Entity < Struct.new(:record)

          def map
            raise MapperNotImplementedError
          end

        end

        class ActiveRecord < Struct.new(:entity)

          def map
            raise MapperNotImplementedError
          end

        end
      end
    end
  end
end
