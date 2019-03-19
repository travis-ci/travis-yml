require 'active_record'
require 'zlib'

ENV['DATABASE_URL'] ||= 'postgresql://localhost/travis_yaml'

MIGRATIONS_DIR = ENV['MIGRATIONS_DIR'] || [path]

ActiveRecord::Base.logger = Logger.new STDOUT
ActiveRecord::Base.establish_connection
config = ActiveRecord::Base.configurations['default_env']

namespace :db do
  desc 'Create the database'
  task :create do
    database = ActiveRecord::Tasks::PostgreSQLDatabaseTasks.new(config)
    database.create
    puts "Database created"
  end

  desc 'Drop the database'
  task :drop do
    database = ActiveRecord::Tasks::PostgreSQLDatabaseTasks.new(config)
    database.drop
    puts "Database dropped"
  end

  desc 'Migrate the database (options: VERSION=x, VERBOSE=false).'
  task :migrate do
    begin
      version = ENV["VERSION"] ? ENV["VERSION"].to_i : nil
      scope   = ENV['SCOPE']
      ActiveRecord::Migrator.migrate(MIGRATIONS_DIR, version) do |migration|
        scope.blank? || scope == migration.scope
      end
    end
  end

  desc 'Rolls the schema back to the previous version (specify steps w/ STEP=n).'
  task :rollback do
    step = ENV['STEP'] ? ENV['STEP'].to_i : 1
    ActiveRecord::Migrator.rollback(MIGRATIONS_DIR, step)
  end
end
