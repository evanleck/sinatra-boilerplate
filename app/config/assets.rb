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
    compass.output_style = development? ? :expanded : :compressed
  end

  # turn on JS/CSS compression on production
  if production?
    settings.sprockets.js_compressor = Uglifier.new
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

    # clean that thang out (defaults to keeping 2 previous versions I believe)
    config.manifest.clean

    # scoop up the images so they can come along for the party
    images = Dir.glob(File.join(settings.assets_path, 'images', '**', '*')).map do |filepath|
      filepath.split('/').last
    end

    # note: .coffee files need to be referenced as .js for some reason
    # note 2: in this case, we're not using Sprockets' directive processor (https://github.com/sstephenson/sprockets#the-directive-processor) but you can do that if you like.
    javascript_files = Dir.glob(File.join(settings.assets_path, 'javascripts', '**', '*')).map do |filepath|
      filepath.split('/').last.gsub(/coffee/, 'js')
    end

    # write the digested files out to public/assets (makes it so Nginx can serve them directly)
    config.manifest.compile(%w(style.css) | javascript_files | images)
  end
end
