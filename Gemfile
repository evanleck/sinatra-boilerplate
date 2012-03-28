# = Gemfile containing requirements for this app =
#     see http://gembundler.com/ for more on how to use this file

# = source (there are others but whatever)
source :rubygems

# = All =
gem 'rack'                      # the base of the base
gem 'sinatra'                   # the base of our web app
gem 'sinatra-flash', require: 'sinatra/flash' # enables flash[:notice] && flash[:error]
gem 'thin'                      # thin server

group :production do
  gem 'pony'
end

group :development do
  gem 'compass'
  
  gem 'guard'                   # follow files and guard them
  gem 'guard-shell'
end