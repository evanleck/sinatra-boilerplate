# Sinatra Boilerplate

A great place to start with [Sinatra](http://www.sinatrarb.com/), [HTML5 Boilerplate](http://html5boilerplate.com/) and [Compass](http://compass-style.org/) all cooked together.

## HTML5 Boilerplate

sinatra-boilerplate uses *some* of the utter uber-hawtness that is the [HTML5 Boilerplate](http://html5boilerplate.com/) but *not all*. I opted not to use the build script stuff because I feel like it adds an extra layer of trouble when working with Sinatra.

The base layout file is pretty compliant with what the Boilerplate puts out but I've added in `Modernizr.load` instead of putting all the JS at the bottom and a few other minor tweaks. Most of the comments have been left in place though.

## Modernizr

[Modernizr](http://www.modernizr.com/) is fantastic and I threw it in because... well, it's fantastic!

## Modernizr.load

I also use `Modernizr.load` a **ton** and recommend you checkout [yepnope.js](http://yepnopejs.com/) for more documentation on it (`Modernizr.load` **is** `yepnope` AFAIK). It provides asynchronous, non-blocking and conditional script loading that is IMO better than just throwing every script in the footer. The reason I like it is because you can spaghetti-code in your JS without worrying about what's loaded or not using the `complete` callback.

For example, let's say you're like everybody else who hasn't been living under a JS rock and are using jQuery. Now let's say you want to execute some code on a specific page but (for whatever reason) you don't have access to the main JS source or don't want to initiate a whole other GET request for like 3 lines of code. In the `head` of your document you have `Modernizr.load` like so:

<pre>
&lt;head>
	&lt;-- some crap... -->
	&lt;script>
		Modernizr.load({
			test: true,
			load: ['//ajax.googleapis.com/ajax/libs/jquery/1.6.2/jquery.min.js', '/js/app.js'],
			complete: function(){
				log('Modernizr finished loading our scripts!');
			}
		});
	&lt;/script>
&lt;/head>
</pre>

Now, you're in your view file (say, the `index.erb` file in this repo) and want to execute some code like this:

<pre>
$('body').addClass('RADSAUCE');
</pre>

**BUT WAIT!** That needs jQuery! This is where the real hot sauce for me is with `Modernizr.load` because in your view file you can throw this bad boy in:

<pre>
&lt;script>
	Modernizr.load({
		complete: function(){
			$('body').addClass('RADSAUCE');
		}
	});
&lt;/script>
</pre>

**BAM!** jQuery already got loaded because we're in the `complete` callback so we just get all crazy with our DOM manipulation without having to sweat it.

[Check out the docs for even more.](http://yepnopejs.com/)

## Compass

Because CSS sucks and SASS + Compass doesn't.

Compass + SASS gives you all kinds of great mixins and nesting stuff that would surely make anyone who's done a lot of CSS quiver in schoolgirl-like delight. Take, for example, some CSS:

<pre>
#content { border: 1px solid red; }
#content p { font-size: 34em; }
#content p.small { font-size: 12em; }
#content em { color: white; }
</pre>

Not so great. You have to write `#content` each time you want to address that element. How about with Compass?

<pre>
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
</pre>

Wait, **what**? Yeah, you can nest it all. If you do any CSS at all in your life ever then you should be using Compass. [Scope the docs and get crackin'.](http://compass-style.org/)


## Extra Hawt Sauce

I've added a bunch of modules and helper functions that I use all the time to this to (hopefully) make your life easier when you're getting your app first setup. Some of the helpers methods I've added include:

* **form tag helpers**
  * stuff like `input_for` and `select_for` to make form construction easier
* **asset tag helpers**
  * stuff like `jit` and `slt`
* **run later**
  * for real, true after filters
* **core extensions**
  * extended Hash class with some useful methods for the web
* **Sinatra extensions**
  * a better `erb` method so you don't have to do crap like `erb :"folder/file"` anymore


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