module Endpoint
  class Projects < Web
    module ListCommit

      def self.registered(app)
        app.get '/:owner/:repo/commits' do
          use_case = ::Projects::ListCommit.new current_project, cursor
          envelope = use_case.run!

          paginate envelope
        end
      end

    end
  end
end
