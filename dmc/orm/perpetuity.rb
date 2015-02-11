require 'perpetuity/postgres'
require 'yaml'

config   = YAML.load_file("#{DMC.root}/config/database.yml")[DMC.env]
database = config.delete('database')

Perpetuity.data_source :postgres, database, config

require_relative './mapper/customers'
require_relative './mapper/projects'
require_relative './mapper/environments'
require_relative './mapper/deployments'
