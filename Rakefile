require 'bundler/setup'
require 'rspec/core/rake_task'

namespace :spec do
  desc "Run tests with fake service"
  RSpec::Core::RakeTask.new(:all)

  desc "Run tests against real services"
  task ci: ['ci_env', 'all']

  task :ci_env do
    ENV['MODE'] = 'ci'
  end
end

task :environment do
  root = File.dirname __FILE__
  require "#{root}/dmc"
end

namespace :sidekiq do
  desc "Empty all sidekiq jobs"
  task clear: :environment do
    Sidekiq::Queue.all.each do |q|
      Sidekiq.redis { |r| r.del "queue:#{q}" }
    end
  end
end

namespace :repository do
  desc "Empty all Repositories"
  task clear: :environment do
    Customers::UserRepository.clear
    Customers::AccountRepository.clear
    Projects::ProjectRepository.clear
    Environments::EnvironmentRepository.clear
    Deployments::DeploymentRepository.clear
  end
end

namespace :db do
  desc "Run migrations"
  task migrate: :environment do |_, args|
    Sequel.extension :migration
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(DB, "dmc/orm/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(DB, "dmc/orm/migrations")
    end
  end
end
