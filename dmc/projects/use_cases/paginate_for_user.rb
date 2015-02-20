module Projects
  class PaginateForUser < Struct.new(:user, :cursor)

    def run!
      projects    = ProjectRepository.paginate_for_user!(user.id, cursor)
      total_count = ProjectRepository.count_for_user!(user.id)

      Envelope.new projects, total_count, cursor
    end

  end
end
