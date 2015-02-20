module Projects
  class ListBranch < Struct.new(:project, :cursor)

    def run!

      total_count = git_branches.count

      branches    = git_branches.drop(cursor.offset).take(cursor.limit).map do |git_branch|
        Branch.new name: git_branch.name
      end

      Envelope.new branches, total_count, cursor
    end

    private

    def git_branches
      @git_branches ||= GitService.branches project.dir
    end

  end
end
