heroku_namespace = namespace :heroku do
  namespace :db do
    desc 'Backup remote production database at Heroku'
    task :export do
      %x(`heroku pg:backups capture`)
      %x(curl -o latest.dump `heroku pg:backups public-url`)
    end

    desc 'Reset local development database with dump'
    task :restore, [:on] => :environment do |_t, args|
      args.with_defaults(on: 'development')
      %x(`RAILS_ENV=#{args.on} rake db:drop`)
      %x(`RAILS_ENV=#{args.on} rake db:create`)
      config = Rails.configuration.database_configuration[args.on.to_s]
      database = config['database']
      puts "Deploy database: #{database}"
      %x(`pg_restore --clean -d #{database} latest.dump`)
      Rake::Task['db:migrate'].invoke
    end

    desc 'Clone remote production database from Heroku into local database'
    task :clone, [:on] => :environment do |_t, args|
      args.with_defaults(on: 'development')
      heroku_namespace['db:export'].invoke
      puts "Restoring on '#{args.on}' stage"
      %x(`RAILS_ENV=#{args.on} rake heroku:db:restore`)
    end
  end
end
