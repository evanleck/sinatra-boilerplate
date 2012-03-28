(function() {

  window.log = function() {
    log.history = log.history || [];
    log.history.push(arguments);
    if (this.console) {
      arguments.callee = arguments.callee.caller;
      return console.log(Array.prototype.slice.call(arguments));
    }
  };

  jQuery(function($) {
    return log("hey, the DOM is loaded!");
  });

}).call(this);
