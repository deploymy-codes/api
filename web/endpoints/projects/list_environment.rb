module Endpoint
  class Projects < Web
    module ListEnvironment

      def self.registered(app)
        app.get '/:project_name/environments' do |project_name|
          use_case     = Environments::List.new current_project
          environments = use_case.run!

          json serialize(environments)
        end
      end

    end
  end
end
