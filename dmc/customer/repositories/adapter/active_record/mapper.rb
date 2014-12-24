module Customer
  module Repository
    module Adapter
      class ActiveRecord
        class Mapper
          class ActiveRecord < ::Repository::Adapter::ActiveRecord::Mapper::ActiveRecord

            def map
              record     = find_or_initialize
              attributes = entity.attributes
              accounts   = attributes.delete :accounts
              record.assign_attributes attributes

              record.accounts = accounts.map do |account|
                record_account = find_or_initialize_account(account)
                record_account.assign_attributes account.attributes
                record_account
              end

              record
            end

            def find_or_initialize
              entity.id.present? ? ::ActiveRecord::User.find(entity.id) : ::ActiveRecord::User.new
            end

            def find_or_initialize_account(account)
              account.id.present? ? ::ActiveRecord::Account.find(account.id) : ::ActiveRecord::Account.new
            end


          end

          class Entity < ::Repository::Adapter::ActiveRecord::Mapper::Entity

            def map
              to_entity_klass.new record.attributes.merge(accounts: record.accounts.map(&:attributes))
            end

          end
        end
      end
    end
  end
end
