module Endpoint
  class Projects < Web
    module Get

      def self.registered(app)
        app.get '/:owner/:repo' do
          json serialize(current_project)
        end

        app.error ::Projects::ProjectRepository::UnknownNameError do
          halt_json_error 404
        end
      end

    end
  end
end
