require 'sinatra'
require "sinatra/reloader"
require "sinatra/json"

class Web < Sinatra::Base
  helpers Sinatra::JSON

  configure :development do
    register Sinatra::Reloader
  end

  helpers do
    def serialize(object)
      serializer_klass = "#{object.class.name}Serializer".constantize
      serializer       = serializer_klass.new(object)
      serializer.as_json
    end

    def extract!(key)
      params.fetch(key.to_s) do
        raise ParameterMissingError, key
      end
    end
  end

end
