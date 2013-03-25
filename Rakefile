# = bundle that shit
require 'rubygems'
require 'bundler/setup'
require './app/core_extensions/try'

Bundler.require(:assets, :sprockets)

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

namespace :assets do
  desc "Compile all of the assets for Sprockets in to ./public/assets for reading by a server. This can also be used in conjuction with a CDN to pre-build assets for production deployment."
  task :compile do
    puts "Compiling assets"

    # some paths
    base        = File.expand_path('../', __FILE__)
    assets_path = File.join( base, 'app', 'assets' )

    # Sprockets + Compressor
    sprockets               = Sprockets::Environment.new(base)
    sprockets.js_compressor = Uglifier.new

    # setup our paths
    %w(stylesheets javascripts images).each do |asset_directory|
      sprockets.append_path File.join(assets_path, asset_directory)
    end

    # configure Compass so it can find images
    Compass.configuration do |compass|
      compass.project_path = assets_path
      compass.images_dir   = 'i'
      compass.fonts_dir    = 'fonts'
      compass.output_style = :compressed
    end

    manifest = Sprockets::Manifest.new(
      sprockets,
      File.join(
        base, 'public', 'assets', 'manifest.json'
      )
    )

    # necessary to make the image URLs work correctly in
    Sprockets::Helpers.configure do |config|
      config.environment = sprockets
      config.prefix      = ''
      config.digest      = true # digests are great for cache busting
      config.manifest    = manifest
    end

    # clean
    manifest.clean(1)

    # get it all together
    # scoop up the images so they can come along for the party
    images = Dir.glob(File.join(assets_path, 'images', '**', '*')).map do |filepath|
      filepath.sub(File.join(assets_path, 'images', '/'), '')
    end

    # grab all the top level CSS files
    css = Dir.glob(File.join(assets_path, 'stylesheets', '*')).map do |filepath|
      if File.file?(filepath)
        File.basename(filepath).gsub(/\.(scss|sass)$/, '.css')
      else
        nil
      end
    end.compact

    # seperate JS files
    # note: .coffee files need to be referenced as .js for some reason
    # note 2: in this case, we're not using Sprockets' directive processor (https://github.com/sstephenson/sprockets#the-directive-processor) but you can do that if you like.
    javascripts = Dir.glob(File.join(assets_path, 'javascripts', '**', '*')).map do |filepath|
      filepath.split('/').last.gsub(/coffee/, 'js')
    end

    # write the digested files out to public/assets
    manifest.compile(css | images | javascripts)
  end
end