class Auth < Web

  get '/:provider' do |provider|
    form     = CodeForm.from_params params
    use_case = FindOrCreateUser.new provider, form
    user  = use_case.run!

    status 201
    json serialize(user)
  end

end
