require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sinatra/cross_origin'

require_relative './parameter_missing_error'
require_relative './api_key_header_missing_error'
require_relative './pagination'

class Web < Sinatra::Base
  register Sinatra::Reloader
  register Sinatra::CrossOrigin

  helpers Sinatra::JSON
  helpers Pagination

  configure do
    enable :cross_origin
  end

  set :server, :thin
  set :show_exceptions, false

  helpers do
    def serialize(object)
      if object.is_a?(Array)
        object.map do |entity|
          serializer_klass = "#{entity.class.name}Serializer".constantize
          serializer_klass.new(entity).run
        end
      else
        serializer_klass = "#{object.class.name}Serializer".constantize
        serializer       = serializer_klass.new(object)
        serializer.run
      end
    end

    def extract!(key)
      params.fetch(key) do
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

    def json_body_params
      MultiJson.load(request.body.read.to_s, symbolize_keys: true)
    rescue MultiJson::ParseError
      {}
    end
  end

  before do
    halt 200 if request.request_method == 'OPTIONS'
  end

  before do
    all_params = params.merge json_body_params
    self.params = ActiveSupport::HashWithIndifferentAccess.new(all_params)
  end

  error ValidationError do
    halt_json_error 403
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

  error Customers::UserRepository::UnknownAPIKeyError do
    halt_json_error 403
  end

end
