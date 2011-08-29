# further requires (models, helpers, core extensions etc. { but not 'middleware' because that should be grabbed up by Rack when appropriate })
Dir.glob('./application/**/*.rb') do |file|
  require file.gsub(/\.rb/, '') unless file.include?('middleware')
end

get '/' do
  @title = 'Hey there!'

  # example usage of run_later
  #   wait 3 seconds after URL is called
  #   output to console
  run_later do
    sleep 3 # go ahead and wait
    dlog "\nLengthy process has finished!\n\n" # outputs to the log AFTER the page has rendered because run_later doesn't block the rest of the process :)
  end

  erb :index
end
