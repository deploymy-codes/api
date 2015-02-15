module Projects
  class ListTag < Struct.new(:project)

    def run!
      git_tags = GitService.tags project.dir

      git_tags.map { |git_tag| Tag.new name: git_tag.name }
    end

  end
end
