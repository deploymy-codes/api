module Deployments
  class FakeRubygemService
    include CommandRunner

    def deploy(_, _, deployment)
      run(deployment) do |runner|
        runner.execute "Build gem", &method(:build)
        runner.execute "Push gem", &method(:push)
        runner.execute "Cleaning", &method(:cleaning)
      end
    end

    def build(command)
      command.update_log stdout: build_result
      true
    end

    def push(command)
      command.update_log stdout: 'Successfully registered gem: deploymycodes (0.0.1)'
      true
    end

    def cleaning(command)
      command.update_log stdout: 'Remove gem file'
      true
    end

    private

    def build_result
      <<-STR
        Successfully built RubyGem
        Name: deploymycodes
        Version: 0.0.1
        File: deploymycodes-0.0.1.gemdone'
      STR
    end
  end
end
