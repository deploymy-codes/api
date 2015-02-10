module Projects
  class FindProject < Struct.new(:project_name, :user)

    def run!
      ProjectRepository.find_by_name_and_user_id!(project_name, user.id)
    end

  end
end
