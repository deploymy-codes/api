require 'sidekiq'

class JobRunner
  extend Interchange.new(*[:perform])

  class Async
    def perform(job, *args)
      job.perform_async(*args)
    end
  end

  class Sync
    def perform(job, *args)
      job.new.perform(*args)
    end
  end
end
