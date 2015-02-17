module Environments
  class Find < Struct.new(:id, :project)

    def run!
      EnvironmentRepository.find(Environment, id)
    end

  end
end
