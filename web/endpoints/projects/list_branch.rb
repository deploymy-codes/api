module Endpoint
  class Projects < Web
    module ListBranch

      def self.registered(app)
        app.get '/:owner/:repo/branches' do
          use_case = ::Projects::ListBranch.new current_project
          branches = use_case.run!

          json serialize(branches)
        end
      end

    end
  end
end
