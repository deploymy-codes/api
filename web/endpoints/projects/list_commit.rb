module Endpoint
  class Projects < Web
    module ListCommit

      def self.registered(app)
        app.get '/:owner/:repo/commits' do
          use_case = ::Projects::ListCommit.new current_project
          commits = use_case.run!

          json serialize(commits)
        end
      end

    end
  end
end
