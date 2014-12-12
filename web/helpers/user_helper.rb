module UserHelper
  def current_user
    api_key = env.fetch 'API_KEY' do
      raise APIKeyHeaderMissingError
    end

    form = Customer::APIKeyForm.new(api_key: api_key)
    Customer::FindUser.new(form).run!
  end
end
