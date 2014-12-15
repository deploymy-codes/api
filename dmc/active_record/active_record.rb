module ActiveRecord
  def self.establish_connection
    database_file_path          = DMC.root.join('config', 'database.yml')
    active_record_configuration = YAML::load(::File.open(database_file_path))[DMC.env]

    ::ActiveRecord::Base.establish_connection(active_record_configuration)
    ::ActiveRecord::Base.logger = Logger.new(::File.open(DMC.root.join('active_record/logs', 'database.log'), 'a'))
  end

  def self.migrate
    migrations_folder = ::File.join(DMC.root, 'active_record', 'migrate')
    ::ActiveRecord::Migrator.migrate(migrations_folder, ENV['VERSION'] ? ENV['VERSION'].to_i : nil )
  end
end

require_relative './models/user'
require_relative './models/account'
require_relative './models/project'
