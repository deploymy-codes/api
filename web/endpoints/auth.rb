class Auth < Web
  helpers do
    def serialize(object)
      klass = "#{object.class.name}Serializer".constantize
      serializer = klass.new(object)
      serializer.as_json
    end
  end

  error ValidationError do
    halt_json_error 422, errors: env['sinatra.error'].as_json
  end

  get '/:provider' do |provider|
    form     = CodeForm.from_params params
    use_case = FindOrCreateUser.new provider, form
    user  = use_case.run!

    status 201
    json serialize(user)
  end
end
