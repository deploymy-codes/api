def create_user(code: 'code', provider: 'github')
  code_form = Customers::CodeForm.new code: code
  Customers::FindOrCreateUser.new(provider, code_form).run!
end
