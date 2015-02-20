module Endpoint
  class Projects < Web
    module ListTag

      def self.registered(app)
        app.get '/:owner/:repo/tags' do
          use_case = ::Projects::ListTag.new current_project, cursor
          envelope = use_case.run!

          paginate envelope
        end
      end

    end
  end
end
