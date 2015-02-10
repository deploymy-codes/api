module Environments
  class EnvironmentRepository < Repository

    class UnknownNameError < StandardError
      def initialize(name)
        @name = name
      end

      def to_s
        "Could not find the environment with name: #{@name}"
      end
    end

    class << self
      def all_for_project!(project_id)
        query Environment, EnvironmentWithProjectId.new(project_id)
      end

      def find_by_name_and_project_id!(name, project_id)
        environment = query Environment, EnvironmentWithNameAndProjectId.new(name, project_id)
        raise UnknownNameError, name if environment.nil?

        environment
      end
    end
  end

  EnvironmentWithNameAndProjectId = Struct.new :name, :project_id
  EnvironmentWithProjectId = Struct.new :project_id
end
