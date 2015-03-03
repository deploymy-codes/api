require 'benchmark'

module Deployments
  module CommandRunner

    def run(deployment, &block)
      runner = Runner.new(deployment)

      block.call runner

      runner
    end

    private

    class Command
      def initialize(name, deployment)
        @name = name
        @log  = CreateLog.new(log_form, deployment.id).run!
      end

      def update_log(attributes = {})
        log_form.attributes = attributes
        @log = UpdateLog.new(@log, log_form).run!
      end

      private

      def log_form
        @log_form ||= LogForm.new name: @name
      end
    end

    class Runner < Struct.new(:deployment)

      def result
        results.all? ? :succeeded : :failed
      end

      def execute(name, &block)
        return unless results.all?

        command = Command.new name, deployment

        duration = Benchmark.realtime do
          results << block.call(command)
        end

        command.update_log duration: duration

        self
      end

      private

      def results
        @results ||= []
      end

    end
  end
end
