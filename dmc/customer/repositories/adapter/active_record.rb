module Customer
  module Repository
    module Adapter
      class ActiveRecord < ::Repository::Adapter::ActiveRecord

        def query_user_with_oauth_token(klass, selector)
          to_entity ::ActiveRecord::Account.find_by(oauth_token: selector.oauth_token).try(:user)
        end

        def query_user_with_email(klass, selector)
          to_entity ::ActiveRecord::User.find_by(email: selector.email)
        end

        def query_user_with_api_key(klass, selector)
          to_entity ::ActiveRecord::User.find_by(api_key: selector.api_key)
        end

        def clear
          ::ActiveRecord::User.destroy_all
          ::ActiveRecord::Account.destroy_all
        end

        def to_active_record(entity)
          return unless entity

          Mapper::ActiveRecord.new(entity).map
        end

        def to_entity(record)
          return unless record

          Mapper::Entity.new(record).map
        end

      end
    end
  end
end
