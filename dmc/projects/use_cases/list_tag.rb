module Projects
  class ListTag < Struct.new(:project, :cursor)

    def run!
      total_count = git_tags.length

      tags        = git_tags.slice(cursor.offset, cursor.limit).map do |git_tag|
        Tag.new name: git_tag.name
      end

      Envelope.new tags, total_count, cursor
    end

    private

    def git_tags
      @git_tags ||= GitService.tags project.dir
    end

  end
end
