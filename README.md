# Sinatra Boilerplate
A great place to start with [Sinatra](http://www.sinatrarb.com/), [HTML5 Boilerplate](http://html5boilerplate.com/), [Compass](http://compass-style.org/), [CoffeeScript](http://coffeescript.org/) and [Sprockets](https://github.com/sstephenson/sprockets) all cooked together.

## TL;DR
1. Grab the code and `bundle` the gems.
2. Make sure you have [memcached](http://www.memcached.org/) installed.
3. Run `rake s` to start the development server.

# What's in the Box
## HTML5 Boilerplate
sinatra-boilerplate uses *some* of the utter uber-hawtness that is the [HTML5 Boilerplate](http://html5boilerplate.com/) but *not all*. I opted not to use the build script stuff because I feel like it adds an extra layer of trouble when working with Sinatra.

The base layout file is pretty compliant with what the Boilerplate puts out except for a few minor tweaks. Most of the comments have been left in place as well.

Direct implementations from HTML5BP:

* `html` scoping by class.
* Viewport settings for mobile browsers.
* Better analytics script.
* More awesome CSS base.
* ... probably more that I've forgotten :)

## Modernizr
[Modernizr](http://www.modernizr.com/) is fantastic and I threw it in because... well, it's fantastic!

## Compass
Because CSS sucks and SASS + Compass doesn't; it gives you all kinds of great mixins and nesting stuff that would surely make anyone who's done a lot of CSS quiver in delight. [Scope the docs and get crackin'.](http://compass-style.org/)

### Susy
Susy is a fantastic grid system built to be responsive and lithe. [Check out the docs here and get griddin'](http://susy.oddbird.net/)

## Sinatra Addons
### Form Tag Helpers
The thing I missed most in Sinatra was the glorious `input_for` kind of stuff you get with Rails, so I made some! I've included them by way of the [gem I made, 'sinatra-tag-helpers'](https://github.com/l3ck/sinatra-tag-helpers).

### Routing Helpers
Some [simple routing helpers](https://github.com/l3ck/sinatra-routing-helpers) I end up using a lot with Sinatra. Methods like:
* `is_page?`
* `url_with_params`
* `back_with_params`
* `parsed_referrer_path`

## Extra Hawt Sauce
I've added a bunch of modules and helper functions that I use all the time to this to (hopefully) make your life easier when you're getting your app first setup. Some of the helpers methods I've added include:

* **Sprockets**
  * holy crap that's nice!!
  * there's a Rake task that pre-compiles your assets so nginx (or Apache or whatever) can serve them up _super_ fast too!
* **core extensions**
  * adds a `try` method and `blank?` method to everything (totally stolen from Rails) so you can stop doing `!nil? && !empty?`
* **Sinatra Modifications**
  * a better `erb` method so you don't have to do crap like `erb :"folder/file"` anymore; just pass a string and it'll take care of the rest (including skipping the layout on XHR requests).

## Server Goodies
* **nginx configuration** - all based on H5BP and a simple upstream setup for Unicorn.
* **logrotate configuration** - so your logs don't get crazy.

## How to Use It
You like it? **Awesome!** Here's how to use it:

1. Download it (either through git or the download button).
2. `bundle`
3. Make sure you have [memcached](http://www.memcached.org/) installed and running (`memcached -d`).
4. Run `rake s` from the directory you checked the code out to.
5. Profit!

If you have suggestions or think I goofed please let me know or send a pull request!

## Acknowledgements
All the stuff used here is either open source or donation ware and totally the work of the people who made it, not me. I just put the pieces together and bundled it up all pretty-like. This little starter package wouldn't be possible without the awesome work these guys have done and their generosity in sharing their code with the rest of us.

Oh, and...

<pre>
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
</pre>

So, ya know, watch out...
