module Customers
  class Find < Struct.new(:form)

    def run!
      form.validate!

      UserRepository.find_by_api_key!(form.api_key)
    end

  end
end
