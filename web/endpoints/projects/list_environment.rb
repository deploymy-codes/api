module Endpoint
  class Projects < Web
    module ListEnvironment

      def self.registered(app)
        app.get '/:owner/:repo/environments' do
          use_case = Environments::PaginateForProject.new current_project, cursor
          envelope = use_case.run!

          paginate envelope
        end
      end

    end
  end
end
