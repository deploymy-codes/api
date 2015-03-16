module Endpoint
  class Webhook < Web

    post '/:provider' do |provider|
      form     = ::Projects::RepositoryForm.new id: extract!(:repository)[:id]
      use_case = ::Projects::Pull.new form
      use_case.run!

      status 200
      ''
    end

  end
end
