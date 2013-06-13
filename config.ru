#
# This file kicks everything off. It:
#  * Loads required gems.
#  * Loads required ruby libraries.
#  * Loads the application code.
#  * Configures session middleware.
#  * Mounts and runs the Sprockets environment at '/assets'.
#  * Mounts and runs the main application at '/'.
#

# = get bundler loaded
require 'rubygems'
require 'bundler/setup'

# load what we need
Bundler.require(:memcached, :sinatra, :assorted, :assets, :sprockets)

# App root configure for everyone else
configure do
  set :app_root, File.expand_path('../', __FILE__)
end

# core Ruby requires and app files
core_requires = %w(securerandom timeout cgi date)
app_files     = Dir.glob('./app/**/*.rb').sort

(core_requires | app_files).each do |requirement|
  require requirement
end

# = Middleware =
# set X-UA-Compatible appropriately
use Rack::Compatible

# Pop open IRB and run `require 'securerandom'; SecureRandom.hex(32)`
#   to generate an unpredictable, 256bit randomly signed session cookies.
#   throw that value in the "secret" key below
use Rack::Session::Dalli,             # session via memcached that sets a cookie reference
  :expire_after => 1800,              # 30 minutes
  :key          => 'rack_session',    # cookie name (probably change this)
  :secret       => 'change me',
  :httponly     => true,              # bad js! No cookies for you!
  :compress     => true,
  :secure       => false,             # NOTE: if you're storing user authentication information in session set this to true and provide pages via SSL instead of standard HTTP or, to quote nkp, "risk the firesheep!" Seriously, don't fuck around with this one.
  :path         => '/'


#
# . . . . . . . . . . . . . . . . _,,,--~~~~~~~~--,_
# . . . . . . . . . . . . . . ,-' : : : :::: :::: :: : : : : :º '-, ITS A TRAP!
# . . . . . . . . . . . . .,-' :: : : :::: :::: :::: :::: : : :o : '-,
# . . . . . . . . . . . ,-' :: ::: :: : : :: :::: :::: :: : : : : :O '-,
# . . . . . . . . . .,-' : :: :: :: :: :: : : : : : , : : :º :::: :::: ::';
# . . . . . . . . .,-' / / : :: :: :: :: : : :::: :::-, ;; ;; ;; ;; ;; ;; ;\
# . . . . . . . . /,-',' :: : : : : : : : : :: :: :: : '-, ;; ;; ;; ;; ;; ;;|
# . . . . . . . /,',-' :: :: :: :: :: :: :: : ::_,-~~,_'-, ;; ;; ;; ;; |
# . . . . . _/ :,' :/ :: :: :: : : :: :: _,-'/ : ,-';'-'''''~-, ;; ;; ;;,'
# . . . ,-' / : : : : : : ,-''' : : :,--'' :|| /,-'-'--'''__,''' \ ;; ;,-'/
# . . . \ :/,, : : : _,-' --,,_ : : \ :\ ||/ /,-'-'x### ::\ \ ;;/
# . . . . \/ /---'''' : \ #\ : :\ : : \ :\ \| | : (O##º : :/ /-''
# . . . . /,'____ : :\ '-#\ : \, : :\ :\ \ \ : '-,___,-',-`-,,
# . . . . ' ) : : : :''''--,,--,,,,,,¯ \ \ :: ::--,,_''-,,'''¯ :'- :'-,
# . . . . .) : : : : : : ,, : ''''~~~~' \ :: :: :: :'''''¯ :: ,-' :,/\
# . . . . .\,/ /|\\| | :/ / : : : : : : : ,'-, :: :: :: :: ::,--'' :,-' \ \
# . . . . .\\'|\\ \|/ '/ / :: :_--,, : , | )'; :: :: :: :,-'' : ,-' : : :\ \,
# . . . ./¯ :| \ |\ : |/\ :: ::----, :\/ :|/ :: :: ,-'' : :,-' : : : : : : ''-,,
# . . ..| : : :/ ''-(, :: :: :: '''''~,,,,,'' :: ,-'' : :,-' : : : : : : : : :,-'''\\
# . ,-' : : : | : : '') : : :¯''''~-,: : ,--''' : :,-'' : : : : : : : : : ,-' :¯'''''-,_ .
# ./ : : : : :'-, :: | :: :: :: _,,-''''¯ : ,--'' : : : : : : : : : : : / : : : : : : :''-,
# / : : : : : -, :¯'''''''''''¯ : : _,,-~'' : : : : : : : : : : : : : :| : : : : : : : : :
# : : : : : : : :¯''~~~~~~''' : : : : : : : : : : : : : : : : : : | : : : : : : : : :
#

# = map it out for me
# sprockets
map Sinatra::Application.settings.assets_prefix do
  run Sinatra::Application.sprockets
end
# main app
map '/' do
  run Sinatra::Application
end
