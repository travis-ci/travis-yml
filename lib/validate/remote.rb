require 'active_record'
require 'sqlite3'

module Remote
  Request = Class.new(ActiveRecord::Base)
  puts 'Connecting to remote db ...'
  Request.establish_connection
  puts 'Connection established.'
end
