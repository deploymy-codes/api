module Endpoint
  class Projects < Web
    module ListBranch

      def self.registered(app)
        app.get '/:owner/:repo/branches' do
          use_case = ::Projects::ListBranch.new current_project, cursor
          envelope = use_case.run!

          paginate envelope
        end
      end

    end
  end
end
