module Deploy
  class EnvironmentRepository < Repository

    class UnknownEnvironmentNameError < StandardError
      def initialize(name)
        @name = name
      end

      def to_s
        "Could not find the environment with name: #{@name}"
      end
    end

    class << self

      def find_by_name_and_project_id!(name, project_id)
        environment = query Environment, EnvironmentWithNameAndProjectId.new(name, project_id)
        raise UnknownEnvironmentNameError, name if environment.nil?

        project
      end

    end

  end

  EnvironmentWithNameAndProjectId = Struct.new :name, :project_id
end
