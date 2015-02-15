module Projects
  class Find < Struct.new(:owner, :repo, :user)

    def run!
      ProjectRepository.find_by_name_and_user_id!(project_name, user.id)
    end

    private

    def project_name
      @project_name ||= [owner, repo] * '/'
    end
  end
end
