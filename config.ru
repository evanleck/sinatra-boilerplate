#\ -s thin -p 4567
# sets `rackup` to use the thin web server on port 4567
# 
require 'bundler' # gem requires

# if you're trying to run your app with Pow (http://pow.cx/) then ENV['RACK_ENV'] might not show up
#   use something else to determine env then :)
Bundler.require(:default, ENV['RACK_ENV'].to_sym)  # only loads environment specific gems

# core Ruby requires, modules and the main app file
%w(base64 digest/sha2 timeout cgi date ./app).each do |requirement|
  require requirement
end

# = Middleware =
use Rack::Session::Pool,              # session via pool that sets a cookie reference
	:expire_after => 1800,              # 30 minutes
	:key          => 'rack.session',    # cookie name (probably change this)
	:secret       => Digest::SHA256.hexdigest(Time.now.to_s), # keeps it random :)
	:httponly     => true,              # bad js! No cookies for you!
	:secure       => false,             # change for more secure cookies
	:path         => '/'

if production? # production config / requires
  require './application/middleware/exceptionmailer'
  
  use Rack::ExceptionMailer, 
    :to      => 'you@yourdomain.com',
    :from    => 'errors@yourdomain.com',
    :subject => 'Error Occurred on Some Rack Application'
  
else # development or testing only
  use Rack::ShowExceptions
end

# = Configuration =
set :run, false
set :server, %w(thin mongrel webrick)
set :show_exceptions, false     # no need because we're using Rack::ShowExceptions
set :raise_errors, true         # let's exceptions propagate to other middleware (ahem mailer ahem)

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
