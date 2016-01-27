require './lib/settings'

namespace :db do
  desc 'Run migrations'
  task :migrate, [:version] do |_, args|
    require 'sequel'
    Sequel.extension :migration
    db = Sequel.connect('sqlite://db/bot.db')
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, 'db/migrations', target: args[:version].to_i)
    else
      puts 'Migrating to latest'
      Sequel::Migrator.run(db, 'db/migrations')
    end
  end
end
