def create_user(code: 'code', provider: 'github')
  code_form = Customer::CodeForm.new code: code
  Customer::FindOrCreateUser.new(provider, code_form).run!
end
