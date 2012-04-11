# = Gemfile containing requirements for this app =
#     see http://gembundler.com/ for more on how to use this file

# = source (there are others but whatever)
source :rubygems

# = All =
gem 'rack'                      # the base of the base
gem 'sinatra'                   # the base of our web app
gem 'sinatra-flash', require: 'sinatra/flash' # enables flash[:notice] && flash[:error]
gem 'erubis'
gem 'thin'                      # thin server

# asset stuff
gem 'coffee-script'   # build the JS
gem 'compass'         # build the CSS

# sprockets galore
gem 'sprockets'
gem 'sprockets-sass'
gem 'sprockets-helpers'

group :production do
  gem 'pony'
end
