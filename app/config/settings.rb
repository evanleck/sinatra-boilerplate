configure do
  # App root
  set :app_root,        File.expand_path('../../../', __FILE__)

  # = Configuration =
  set :run,             false
  set :server,          %w(unicorn)
  set :show_exceptions, false
  set :raise_errors,    development?
  set :views,           File.join(settings.app_root, 'app', 'views')
  set :logging,         true
  set :static,          false # your upstream server should deal with those (nginx, Apache)
end
