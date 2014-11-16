require 'bundler/setup'
require 'rspec/core/rake_task'

namespace :spec do
  desc "Run tests with fake service"
  RSpec::Core::RakeTask.new(:all)

  desc "Run tests against real services"
  task ci: ['ci_env', 'all']

  task :ci_env do
    ENV['CI'] = 'true'
  end
end

task :environment do
  root = File.dirname __FILE__
  require "#{root}/dmc/dmc"
end

namespace :sidekiq do
  desc "Empty all sidekiq jobs"
  task clear: :environment do
    Sidekiq::Queue.all.each do |q|
      Sidekiq.redis { |r| r.del "queue:#{q}" }
    end
  end
end

namespace :repo do
  desc "Empty all repos"
  task clear: :environment do
    Customer::UserRepo.clear
  end
end
