module Customer
  module Repository
    module Adapter
      class ActiveRecord
        class Mapper
          class ActiveRecord < ActiveRecord

            def map
              record = find_or_initialize(entity)
              attribute.delete :accounts
              record.assign_attributes attributes

              record.accounts = entity.accounts.map do |account|
                record = find_or_initialize(account)
                record.assign_attributes account.attributes
                record
              end
            end

          end

          class Entity < Entity

            def map
              to_entity_klass(record.class).new record.attributes.merge(accounts: record.accounts.map(&:attributes))
            end

          end
        end
      end
    end
  end
end
