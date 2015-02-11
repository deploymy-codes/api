require "sinatra/streaming"

module Endpoint
  class Streams < Web
    helpers Sinatra::Streaming

    get '/:deployment_id' do |deployment|
      stream do |out|
        out.flush
      end
    end

  end
end
