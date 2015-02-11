module Endpoint
  class Auth < Web

    post '/:provider' do |provider|
      form     = Customers::CodeForm.from_params params
      use_case = Customers::FindOrCreate.new provider, form

      user     = use_case.run!

      status 201
      json serialize(user)
    end

  end
end
