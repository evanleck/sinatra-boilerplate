(function(window, undefined){
  var document = window.document,
      Modernizr = window.Modernizr;
	
  // usage: log('inside coolFunc', this, arguments);
  // paulirish.com/2009/log-a-lightweight-wrapper-for-consolelog/
  window.log = function(){
    log.history = log.history || [];   // store logs to an array for reference
    log.history.push(arguments);
    if (this.console) {
      arguments.callee = arguments.callee.caller;
      console.log( Array.prototype.slice.call(arguments) );
    };
  };
	
  jQuery(function($){
    // = DOM is ready, let's go!
    log('hey, the DOM is loaded!');
  });

})(window); // = end self invoking anonymous function
	