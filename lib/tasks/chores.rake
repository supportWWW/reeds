namespace :chores do
  
  task :hourly => :environment do
    chore("Hourly") do
      # Your Code Here
    end
  end
  
  task :daily => :environment do
    chore("Daily") do
      Rake::Task['reeds:stocklist:send'].invoke
      Rake::Task['reeds:cyberstock:send_expire'].invoke
    end
  end
  
  task :weekly => :environment do
    chore("Weekly") do
      Rake::Task['reeds:stocklist_weekly:send'].invoke
    end
  end
  
  def chore(name)
    puts "#{name} Task Invoked: #{Time.now}"
    yield
    puts "#{name} Task Finished: #{Time.now}"
  end
end