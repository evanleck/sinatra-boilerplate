
# Avoid `console` errors in browsers that lack a console.
(->
  method = undefined
  noop = noop = ->

  methods = ["assert", "clear", "count", "debug", "dir", "dirxml", "error", "exception", "group", "groupCollapsed", "groupEnd", "info", "log", "markTimeline", "profile", "profileEnd", "table", "time", "timeEnd", "timeStamp", "trace", "warn"]
  length = methods.length
  console = (window.console = window.console or {})
  while length--
    method = methods[length]

    # Only stub undefined methods.
    console[method] = noop  unless console[method]
)()

# woo jquery
jQuery ($) ->
  console.log "hey, the DOM is loaded!"
