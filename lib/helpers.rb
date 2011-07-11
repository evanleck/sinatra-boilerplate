# ===========
# = Helpers =
# ===========
helpers do
  # helpers
  include Rack::Utils
  alias_method :h, :escape_html
  alias_method :e, :escape
  
  
  # overrides Sinatra's defaults to allow calling like this:
  #   erb 'partials/flash'
  # 
  # instead of
  #   erb 'partials/flash'.to_sym
  # 
  # or
  #   erb :"partials/flash"
  # 
  # which is just weird and ugly.
  def erb path, *args
    path = path.to_sym
    super
  end
  
  # link helper
  def link_to text, link, args = {}
  	if link == request.path_info
  		args[:class] = "#{ args[:class] } current"
  	end
  
    "<a href='#{ link }' #{ args.to_attr }>#{ text }</a>"
  end
  
  # Returns the url of the referer along with the params posted to that page
  # Lets you hand back invalid params for correction in the previous page.
  def back_with_params o = {}
    rejected_keys = [:password] # these won't be passed back to the page
    back_to = request.referer ? request.referer : '/'
    params_string = params.blank? ? '' : "?#{ build_query(o.merge(params).delete_if { |k, v| rejected_keys.include?(k.to_sym) }) }"
    
    back_to + params_string
  end
  
  # handles a non-working cancel button
  def back_or new_path
    if back == '/' || back == request.path_info
      new_path
    else
      back
    end
  end
  
  # really simple, easily cracked string obfuscator
  def encode plain_text
    Base64.urlsafe_encode64(plain_text)
  end
  # de-fuscator
  def decode encoded_text
    Base64.urlsafe_decode64(encoded_text)
  end
  
  # checks the params hash for a single argument as both !nil and !empty
  def ensure_param arg
    return !params[arg.to_sym] || !params[arg.to_sym].empty?
  end
  
  # checks an array of params from the params hash
  def ensure_params args
    truthy = true
    
    args.each do |arg|
      truthy = ensure_param arg
      break unless truthy
    end
    
    truthy
  end
  
  # debug log to server log if development
  # else outputs nothing (for production)
  def dlog(*args)
    if development?
      puts "\n================================================\n"
      for arg in args
        puts arg
        puts "================================================\n"
      end
    end
  end
end
