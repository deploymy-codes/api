module Customer
  class FindUser < Struct.new(:form)

    def run!
      form.validate!

      UserRepo.find_by_api_key!(form.api_key)
    end

  end
end
