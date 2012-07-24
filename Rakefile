# The default, if you just run `rake` in this directory, will list all the available tasks
task :default do
  puts "All available rake tasks"
  system('rake -T')
end

desc "Start Unicorn in development mode and get memcached running"
task :s do
  system("bundle exec foreman start")
end