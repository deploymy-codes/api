module Endpoint
  class Projects < Web
    module List

      def self.registered(app)
        app.get '/' do
          use_case = ::Projects::PaginateForUser.new current_user, cursor
          envelope = use_case.run!

          paginate envelope
        end
      end

    end
  end
end
