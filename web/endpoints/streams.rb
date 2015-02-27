require "sinatra/streaming"

module Endpoint
  class Streams < Web
    helpers Sinatra::Streaming

    =BEGIN
    command_name: dsdasdsadasdasdas
    duration: 1000
    command_output: sadasdasdasdasdasd

    ....
    =END
    get '/:deployment_id' do |deployment|
      stream do |out|
        out.flush
      end
    end

  end
end
