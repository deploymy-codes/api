module Deploy
  class ListProject < Struct.new(:user)

    def run!
      ProjectRepository.all_for_user!(user.id)
    end

  end
end
