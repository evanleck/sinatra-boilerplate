configure do
  # sprockets setup
  set :sprockets,     Sprockets::Environment.new(settings.app_root)
  set :assets_prefix, '/assets'
  set :assets_path,   File.join(settings.app_root, 'app', 'assets')

  # setup our paths
  %w(stylesheets javascripts images).each do |asset_directory|
    settings.sprockets.append_path File.join(settings.assets_path, asset_directory)
  end

  # configure Compass so it can find images
  Compass.configuration do |compass|
    compass.project_path = settings.assets_path
    compass.images_dir   = 'images'
    compass.output_style = :expanded
  end

  # configure Sprockets::Helpers
  Sprockets::Helpers.configure do |config|
    config.environment = settings.sprockets
    config.prefix      = settings.assets_prefix
    config.digest      = true # digests are great for cache busting
    config.manifest    = Sprockets::Manifest.new(
      settings.sprockets,
      File.join(
        settings.app_root, 'public', 'assets', 'manifest.json'
      )
    )
  end
end
