require 'sequel'

DB = sequel.sqlite("./db/#{ENV.fetch('RACK_ENV', 'development')}.db")
