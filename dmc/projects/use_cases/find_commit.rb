module Projects
  class FindCommit < Struct.new(:project_id, :sha)

    def run!
      project = Find.new(project_id).run!
      GitService.commit project.dir, sha
    end

  end
end
