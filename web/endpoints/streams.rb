require "sinatra/streaming"

require_relative "../helpers/user_helper"
require_relative "../helpers/project_helper"

module Endpoint
  class Streams < Web
    helpers Sinatra::Streaming
    helpers UserHelper
    helpers ProjectHelper

    get '/:owner/:repo/environments/:environment_name/deployments/:deployment_id' do
      stream do |out|
        out.puts '{ "logs": ['
        logs = json_logs
        out.puts logs

        while current_deployment.unfinished? do
          out.puts ',' if logs.present?

          logs = json_logs
          out.puts logs

          sleep 5
        end

        out.puts ']}'
        out.flush
      end
    end

    private

    def json_logs
      logs = Deployments::ListLog.new(current_deployment).run!

      logs.map do |log|
        serialize(log).to_json
      end.join ','
    end

  end
end
