module Projects
  class ListBranch < Struct.new(:project)

    def run!
      git_branches = GitService.branches project.dir

      git_branches.map { |git_branch| Branch.new name: git_branch.name }
    end

  end
end
