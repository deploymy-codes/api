module Endpoint
  class Projects < Web
    module List

      def self.registered(app)
        app.get '/' do
          use_case = ::Projects::List.new current_user
          projects = use_case.run!

          json serialize(projects)
        end
      end

    end
  end
end
