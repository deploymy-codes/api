module Sessions
  class Create < Struct.new(:params)

    def self.call(params)
      new(params).call
    end

    def call
      oauth = params[:oauth]
      return unless oauth.present?

      user = params[:user]

      if user.present?
        create_new_account
      else
        user = login
        create_new_account
      end
    end

    private

    def repository
      @user_repository ||= UserRepository.new
    end
  end
end
