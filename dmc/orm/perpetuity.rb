require 'perpetuity/postgres'

Perpetuity.data_source :postgres, '',
  host: '',
  port: ,
  username: '',
  password: ''

require_relative './mapper/customer'
