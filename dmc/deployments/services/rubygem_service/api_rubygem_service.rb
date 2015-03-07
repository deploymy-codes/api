module Deployments
  class APIRubygemService

    def deploy(project, environment, deployment)
      Deployer.new(project, environment, deployment).deploy
    end

    class Deployer < Struct.new(:project, :environment, :deployment)
      include CommandRunner

      def deploy
        run(deployment) do |runner|
          runner.execute "Checkout commit", &method(:checkout)
          runner.execute "Build gem", &method(:build)
          runner.execute "Push gem", &method(:push)
          runner.execute "Cleaning", &method(:cleaning)
        end
      end

      def checkout(command)
        Dir.chdir(project.dir) do
          `git checkout #{deployment.sha}`
        end

        command.update_log stdout: "Commit successfully checkout"
      end

      def build(command)
        result = Dir.chdir(project.dir) do
          gemspec = Dir.entries('.').find { |file| file.end_with? '.gemspec' }
          `gem build #{gemspec}`
        end

        command.update_log stdout: result
        result.include? 'Successfully'
      end

      def push(command)
        configure_gems

        result = Dir.chdir(project.dir) do
          gem = Dir.entries('.').find { |file| file.end_with? '.gem' }

          Gems.push File.new gem
        end

        command.update_log stdout: result
        result.include? 'Successfully'
      end

      def cleaning(command)
        Dir.chdir(project.dir) do
          gem = Dir.entries('.').find { |file| file.end_with? '.gem' }
          File.delete gem
        end

        command.update_log stdout: 'Remove gem file'
        true
      end

      private

      def configure_gems
        Gems.configure do |config|
          config.key = environment.rubygem_api_key
        end
      end
    end
  end
end
