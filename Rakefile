# The default, if you just run `rake` in this directory, will list all the available tasks
task :default do
  puts "All available rake tasks"
  system('rake -T')
end

desc "Start Unicorn in development mode"
task :s do
  system("unicorn -c config/unicorn.rb -E development")
end

desc "Star memcached as a daemon"
task :memcached do
  system('memcached -d')
end

# NOTE: unicorn:start should be run on production to start the system up
namespace :unicorn do
  desc "Start Unicorn"
  task :start do
    puts "Unicorns unleashed" if system("unicorn -c config/unicorn.rb -D -E production")
  end

  desc "Stop Unicorn"
  task :stop do
    if unicorn_pid
      puts "Unicorn killed (womp womp)" if system("kill -s QUIT #{ unicorn_pid }")
    else
      puts "No Unicorn to kill"
    end
  end

  desc "Graceful reload"
  task :reload do
    if unicorn_pid
      puts "Unicorn reloaded" if system("kill -s USR2 #{ unicorn_pid }")
    else
      puts "No PID to reload"
    end
  end
end

# read that PID
def unicorn_pid
  File.read("./tmp/unicorn.pid") || false
end

# NOTE: this is the right place for Ubuntu but your system may vary
namespace :logrotate do
  desc "Place the logrotate config in the appropriate place"
  task :place do
    puts "logrotate config placed at /etc/logrotate.d/example-unicorn" if system("sudo cp 'config/logrotate' '/etc/logrotate.d/example-unicorn'")
  end
end