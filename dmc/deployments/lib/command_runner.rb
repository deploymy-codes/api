require 'benchmark'

module Deployments
  module CommandRunner

    def run(project, environment, deployment, &block)
      define_getter(project, environment, deployment)
      runner = Runner.new(deployment)

      block.call runner

      runner
    end

    private

    def define_getter(project, environment, deployment)
      define_singleton_method :project,     -> { project  }
      define_singleton_method :environment, -> { environment  }
      define_singleton_method :deployment,  -> { deployment  }
    end

    class Runner < Struct.new(:deployment)

      def result
        results.all? ? :succeeded : :failed
      end

      def execute(name, &block)
        return unless results.all?

        log_form = LogForm.new name: name
        log      = CreateLog.new(log_form, deployment.id).run!

        log_form.duration = Benchmark.realtime do
          results << block.call(log_form)
        end

        UpdateLog.new(log, log_form).run!
        self
      end

      private

      def results
        @results ||= []
      end

    end
  end
end
