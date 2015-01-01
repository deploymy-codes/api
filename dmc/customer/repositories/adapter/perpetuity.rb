module Customer
  module Repository
    module Adapter
      class Perpetuity < ::Repository::Adapter::Perpetuity

        # see: https://github.com/jgaskins/perpetuity/issues/53
        # when fixed we can improve this method and remove
        # the user attributes in account
        def query_user_with_oauth_token(klass, selector)
          mapper  = mapper_for Customer::Account
          account = mapper.find { |account| account.oauth_token == selector.oauth_token }

          return unless account.present?

          user = all(klass).find { |user| user.accounts.map(&:id).include? account.id }
          mapper_for(klass).load_association! user, :accounts
          user
        end

        def query_user_with_email(klass, selector)
          mapper = mapper_for klass
          user   = mapper.find { |user| user.email == selector.email }

          mapper.load_association! user, :accounts
          user
        end

        def query_user_with_api_key(klass, selector)
          mapper = mapper_for klass
          user   = mapper.find { |user| user.api_key == selector.api_key }
          mapper.load_association! user, :accounts
          user
        end

        def clear
          mapper_for(Customer::User).delete_all
          mapper_for(Customer::Account).delete_all
        end
      end
    end
  end
end
