module Endpoint
  class Projects < Web
    module ListTag

      def self.registered(app)
        app.get '/:owner/:repo/tags' do
          use_case = ::Projects::ListTag.new current_project
          tags = use_case.run!

          json serialize(tags)
        end
      end

    end
  end
end
