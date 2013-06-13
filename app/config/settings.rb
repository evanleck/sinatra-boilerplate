configure do
  # = Configuration =
  set :run,               false
  set :server,            %w(unicorn)
  set :show_exceptions,   false
  set :raise_errors,      development?
  set :views,             File.join(settings.app_root, 'app', 'views')
  set :logging,           true
  set :static,            false # your upstream server should deal with those (nginx, Apache)
  set :notification_to,   %w(you@example.com)
  set :notification_from, 'service@example.com'
end
