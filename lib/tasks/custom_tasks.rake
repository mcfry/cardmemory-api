namespace :db do

  # lock for autoscheduled tasks
  # def cron_lock(name)
  #   path = Rails.root.join('tmp', 'cron', "#{name}.lock")
  #   mkdir_p path.dirname unless path.dirname.directory?
  #   file = path.open('w')
  #   return if file.flock(File::LOCK_EX | File::LOCK_NB) == false
  #   yield
  # end

  namespace :custom_migrate do
    desc 'Purge files, migrate:reset, and seed'
    task reset: :environment do
      # Purge all file data, leave folders
      begin
        ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
      rescue => e
        # already deleted
        puts "Already deleted"
      end

      begin
        # remove empty directories because not supported LUL
        Dir.glob(Rails.root.join('storage', '**', '*').to_s).sort_by(&:length).reverse.each do |x|
          if File.directory?(x) && Dir.empty?(x)
            Dir.rmdir(x)
          end
        end
      rescue => e
          puts "No empty directories to delete, or error"
      end

      # Run standard migrate:reset
      Rake::Task['db:migrate:reset'].invoke

      # freezes up?

      # Run seeds.rb if it exists
      filename = File.join(Rails.root, 'db', 'seeds.rb')
      load(filename) if File.exist?(filename)
    end
  end

  namespace :custom do
    desc 'Purge files'
    task purge_files: :environment do
        # Purge all file data, leave folders
        begin
          ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
        rescue => e
          # already deleted
          puts "Already deleted"
        end

        begin
          # remove empty directories because not supported LUL
          Dir.glob(Rails.root.join('storage', '**', '*').to_s).sort_by(&:length).reverse.each do |x|
            if File.directory?(x) && Dir.empty?(x)
              Dir.rmdir(x)
            end
          end
        rescue => e
            puts "No empty directories to delete, or error"
        end
    end
  end
end
