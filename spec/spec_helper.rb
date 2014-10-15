require 'rack/test'

require File.expand_path '../../app/routes/root.rb', __FILE__

set :environment, :test

include Rack::Test::Methods

def app
  Sinatra::Application
end
