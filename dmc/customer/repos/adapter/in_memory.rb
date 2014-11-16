module Customer
  module Repo
    module Adapter
      class InMemory < ::Repo::Adapter::InMemory

        def query_user_with_oauth_token(klass, oauth_token)
          all(klass).find { |user| user.account.oauth_token == oauth_token }
        end
      end
    end
  end
end
