module UserHelper
  def current_user
    api_key = env.fetch 'HTTP_AUTHORIZATION' do
      raise APIKeyHeaderMissingError
    end

    form = Customers::APIKeyForm.new(api_key: api_key)
    Customers::Find.new(form).run!
  end
end
