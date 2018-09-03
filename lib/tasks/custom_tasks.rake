namespace :db do

  # lock for autoscheduled tasks
  def cron_lock(name)
    path = Rails.root.join('tmp', 'cron', "#{name}.lock")
    mkdir_p path.dirname unless path.dirname.directory?
    file = path.open('w')
    return if file.flock(File::LOCK_EX | File::LOCK_NB) == false
    yield
  end

  namespace :custom_migrate do
    desc 'Purge files, migrate:reset, and seed'
    task reset: :environment do
      # Purge all file data, leave folders
      ActiveStorage::Attachment.all.each { |attachment| attachment.purge }

      # Run standard migrate:reset
      Rake::Task['db:migrate:reset'].invoke

      # Run seeds.rb if it exists
      filename = File.join(Rails.root, 'db', 'seeds.rb')
      load(filename) if File.exist?(filename)
    end
  end

end