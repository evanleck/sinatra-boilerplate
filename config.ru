#\ -s thin -p 4567
# sets `rackup` to use the thin web server on port 4567
# 
require 'bundler'               # gem requires

# if you're trying to run your app with Pow (http://pow.cx/) then ENV['RACK_ENV'] might not show up
#   use something else to determine env then :)
Bundler.require(:default, ENV['RACK_ENV'].to_sym)  # only loads environment specific gems

# core Ruby requires, modules and the main app file
%w(base64 timeout cgi date ./lib/constants ./app).each do |requirement|
  require requirement
end

# ==============
# = Middleware =
# ==============
# if problems come up with people being logged out, add:
#   :renew => true
# to the end of this call
use Rack::Session::Pool,        # session via pool that sets a cookie reference
	:expire_after => 1800,        # 30 minutes
	:key => 'rack.session',       # cookie name (probably change this)
	:secret => '374J2977311JQR87Jd3c9UKr3b8DGU', # probably change this too
	:httponly => true,
	:secure => false,             # change for more secure cookies
	:path => '/'

use Rack::Flash                 # provides flash[:notice] and flash[:error] support
use Rack::Static,               # trying to catch these for static files
  :urls => ["/css", "/images", "/js"], 
  :root => "public"             # local folder root for public resources

if production?                  # production config / requires
  require './lib/middleware/exceptionmailer'
  
  use Rack::ExceptionMailer, 
    :to => 'you@yourdomain.com',
    :from => 'errors@yourdomain.com',
    :subject => 'Error Occurred on Some Rack Application'
  
else                            # development or testing only
  use Rack::ShowExceptions
end

# =================
# = Configuration =
# =================
set :run, false
set :server, %w(thin mongrel webrick)
set :show_exceptions, false     # no need because we're using Rack::ShowExceptions
set :raise_errors, true         # let's exceptions propagate to other middleware (ahem mailer ahem)

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
run Sinatra::Application

