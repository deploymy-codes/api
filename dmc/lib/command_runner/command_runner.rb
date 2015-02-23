module CommandRunner

  def command
    @command ||= Command.new
  end

  class Command
    def run(name, &block)
      log = Log.new name: name
      LogRepository.save log

      duration = Benchmark.realtime do
        block.call log
      end

      log.duration = duration * 1000
      LogRepository.save log
    end
  end

end
