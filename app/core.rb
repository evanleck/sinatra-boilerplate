before do
  # opt into the future
  response['X-UA-Compatible'] = "IE=edge,chrome=1"
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
