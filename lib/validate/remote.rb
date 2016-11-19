require 'active_record'
require 'sqlite3'

module Remote
  Repository = Class.new(ActiveRecord::Base)
  Request = Class.new(ActiveRecord::Base)
  puts 'Connecting to remote db ...'
  Repository.establish_connection
  Request.establish_connection
  puts 'Connection established.'
end
