# Sinatra Boilerplate

A great place to start with [Sinatra](http://www.sinatrarb.com/), [HTML5 Boilerplate](http://html5boilerplate.com/) and [Compass](http://compass-style.org/) all cooked together.

## HTML5 Boilerplate

sinatra-boilerplate uses *some* of the utter uber-hawtness that is the [HTML5 Boilerplate](http://html5boilerplate.com/) but *not all*. I opted not to use the build script stuff because I feel like it adds an extra layer of trouble when working with Sinatra.

The base layout file is pretty compliant with what the Boilerplate puts out but I've added in `Modernizr.load` instead of putting all the JS at the bottom and a few other minor tweaks. Most of the comments have been left in place though.

Direct implementations from HTML5BP:

* `html` scoping by class.
* Internet explorer compatibility `meta` tag.
* Viewport settings for mobile browsers.
* Better analytics script.
* Prompt IE6 users to use Chrome Frame.
* ... probably more that I've forgotten :)

## Modernizr

[Modernizr](http://www.modernizr.com/) is fantastic and I threw it in because... well, it's fantastic!

## Modernizr.load

I also use `Modernizr.load` a **ton** and recommend you checkout [yepnope.js](http://yepnopejs.com/) for more documentation on it (`Modernizr.load` **is** `yepnope` AFAIK). It provides asynchronous, non-blocking and conditional script loading that is IMO better than just throwing every script in the footer. The reason I like it is because you can spaghetti-code in your JS without worrying about what's loaded or not using the `complete` callback.

For example, let's say you're like everybody else who hasn't been living under a JS rock and are using jQuery. Now let's say you want to execute some code on a specific page but (for whatever reason) you don't have access to the main JS source or don't want to initiate a whole other GET request for like 3 lines of code. In the `head` of your document you have `Modernizr.load` like so:

```html
<head>
	<!-- some crap... -->
	<script>
		Modernizr.load({
			test: true,
			load: ['//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js', '/js/app.js'],
			complete: function(){
				log('Modernizr finished loading our scripts!');
			}
		});
	</script>
</head>
```

Now, you're in your view file (say, the `index.erb` file in this repo) and want to execute some code like this:

```javascript
$('body').addClass('RADSAUCE');
```

**BUT WAIT!** That needs jQuery! This is where the real hot sauce for me is with `Modernizr.load` because in your view file you can throw this bad boy in:

```javascript
Modernizr.load({
	complete: function(){
		$('body').addClass('RADSAUCE');
	}
});
```

**BAM!** jQuery already got loaded because we're in the `complete` callback so we just get all crazy with our DOM manipulation without having to sweat it.

[Check out the docs for even more.](http://yepnopejs.com/)

## Compass

Because CSS sucks and SASS + Compass doesn't.

Compass + SASS gives you all kinds of great mixins and nesting stuff that would surely make anyone who's done a lot of CSS quiver in schoolgirl-like delight. Take, for example, some CSS:

```css
#content { border: 1px solid red; }
#content p { font-size: 34em; }
#content p.small { font-size: 12em; }
#content em { color: white; }
```

Not so great. You have to write `#content` each time you want to address that element. How about with Compass?

```scss
#content {
	border: 1px solid red;
	
	p {
		font-size: 34em;
		
		&amp;.small {
			font-size: 12em;
		}
	}
	em {
		color: white;
	}
}
```

Wait, **what**? Yeah, you can nest it all. If you do any CSS at all in your life ever then you should be using Compass.

[Scope the docs and get crackin'.](http://compass-style.org/)


## Sinatra Addons

### Run Later

After filters are great and all, but they block the rendering of the page and that sucks. I want to be able to, mid-render, tell Ruby to go off and do some stuff that I know will take a long time without it stopping the current page. Think of it as an asynchronous (ya know, like AJAX) Ruby request!

This is a plain insert of my [Sinatra run_later module](https://github.com/l3ck/sinatra_run_later), which I based off of [this run_later module](https://github.com/pmamediagroup/sinatra_run_later) which is based off of [THIS run_later module](https://github.com/mattmatt/run_later). Use it like so:

```ruby
require 'rubygems'
require 'sinatra'
require 'run_later'

get '/' do
  run_later do
    # some task that you don't want to block.
    sleep 20
  end

  "Hello World"
end
```








### Form Tag Helpers

The thing I missed most in Sinatra was the glorious `input_for` kind of stuff you get with Rails, so I made some!

```ruby
# input_for
input_for :first_name # => <input type='text' name='first_name' id='first_name' value=''>

# input_for with options
input_for :email, :type => 'email', :required => nil # => <input type='email' name='email' id='email' required value=''>

# select_for
select_for 'days', { :monday => 'Monday', :myday => 'MY DAY!' }

# yields
# <select name='days' id='days' size='1'>
# 	<option value='monday'>Monday</option>
#     <option value='myday'>MY DAY!</option>
# </select>
```







## Extra Hawt Sauce

I've added a bunch of modules and helper functions that I use all the time to this to (hopefully) make your life easier when you're getting your app first setup. Some of the helpers methods I've added include:

* **asset tag helpers**
  * stuff like `jit` and `slt`
* **core extensions**
  * extended Hash class with some useful methods for the web
* **Sinatra extensions**
  * a better `erb` method so you don't have to do crap like `erb :"folder/file"` anymore


## How to Use It

You like it? **Awesome!** Here's how to use it:

1. Hit the download link at the top of the page.
2. Start hacking.

Or if you want the more Git-y way:

1. Clone this project: `git clone git://github.com/l3ck/sinatra-boilerplate.git sinatra-boilerplate`
2. `CD` into the clone: `cd sinatra-boilerplate`
3. Export a clean version: `git checkout-index --prefix=git-export-dir/ -a`
4. Move the newly created folder `git-export-dir` out of
   `sinatra-boilerplate` with some meaningfulish name.
6. Start hacking! Your boilerplate is in that directory!

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
