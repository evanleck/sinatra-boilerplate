# sprockets setup
set :sprockets_root,  File.expand_path('../', __FILE__)
set :sprockets,       Sprockets::Environment.new
set :assets_prefix,   '/assets'
set :assets_path,     File.join(settings.sprockets_root, settings.assets_prefix)

configure do
  # setup our paths
  settings.sprockets.append_path File.join(settings.assets_path, 'stylesheets')
  settings.sprockets.append_path File.join(settings.assets_path, 'javascripts')
  settings.sprockets.append_path File.join(settings.assets_path, 'images')

  # configure Compass so it can find images
  Compass.configuration do |compass|
    compass.project_path = settings.assets_path
    compass.images_dir   = 'images'
    compass.output_style = :compressed
  end
  
  # configure Sprockets::Helpers
  Sprockets::Helpers.configure do |config|
    config.environment = settings.sprockets
    config.prefix      = settings.assets_prefix
    config.digest      = true
    config.manifest    = Sprockets::Manifest.new(
      settings.sprockets,
      File.join(
        File.expand_path('../../public/assets', __FILE__), 'manifest.json'
      )
    )
    
    # clean that thang out
    config.manifest.clean
    
    # scoop up the images so they can come along for the party
    images = Dir.glob(File.join(settings.assets_path, 'images', '**', '*')).map do |filepath|
      filepath.split('/').last
    end

    # note: .coffee files need to be referenced as .js for some reason
    javascript_files = Dir.glob(File.join(settings.assets_path, 'javascripts', '**', '*')).map do |filepath|
      filepath.split('/').last.gsub(/coffee/, 'js')
    end

    # write the digested files out to public/assets (makes it so Nginx can serve them directly)
    config.manifest.compile(%w(style.css) | javascript_files | images)
  end
end
