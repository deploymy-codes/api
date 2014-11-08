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

    def halt_json_error(code, errors = {})
      json_error env.fetch('sinatra.error'), code, errors
    end

    def json_error(ex, code, errors = {})
      halt code, { 'Content-Type' => 'application/json' }, JSON.dump({
        error: { message: ex.message }
      }.merge(errors))
    end
  end

  error ParameterMissingError do
    halt_json_error 400
  end

  error UnknownFormFieldError do
    halt_json_error 400
  end

  error RecordNotFoundError do
    halt_json_error 404
  end

end
