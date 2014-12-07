class Users < Web

  helpers do
    def current_user
      api_key = env.fetch 'API_KEY' do
        raise APIKeyHeaderMissingError
      end

      form = Customer::APIKeyForm.new(api_key: api_key)
      Customer::FindUser.new(form).run!
    end
  end

  get '/self' do
    json serialize(current_user)
  end

  error Customer::UserRepository::UnknownApiKeyError do
    halt_json_error 403
  end
end
