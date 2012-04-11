# sprockets setup
set :sprockets_root,  File.expand_path('../', __FILE__)
set :sprockets,       Sprockets::Environment.new
set :assets_prefix,   '/assets'
set :assets_path,     File.join(settings.sprockets_root, settings.assets_prefix)
  
configure do
  settings.sprockets.append_path(File.join(settings.assets_path, 'stylesheets'))
  settings.sprockets.append_path(File.join(settings.assets_path, 'javascripts'))
  settings.sprockets.append_path(File.join(settings.assets_path, 'images'))
  
  # Configure Sprockets::Helpers (if necessary)
  Sprockets::Helpers.configure do |config|
    config.environment = settings.sprockets
    config.prefix      = settings.assets_prefix
    config.digest      = true
  end
end
