require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'

require_relative './parameter_missing_error'
require_relative './api_key_header_missing_error'

class Web < Sinatra::Base
  helpers Sinatra::JSON

  register Sinatra::Reloader

  helpers do
    def serialize(object)
      if object.is_a?(Array)
        serializer_klass = "#{object.first.class.name}Serializer".constantize
        object.map { |entity| serializer_klass.new(entity).run }
      else
        serializer_klass = "#{object.class.name}Serializer".constantize
        serializer       = serializer_klass.new(object)
        serializer.run
      end
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

  error EntityNotFoundError do
    halt_json_error 404
  end

  error APIKeyHeaderMissingError do
    halt_json_error 412
  end
end
