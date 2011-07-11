
# ================
# = Form Helpers =
# ================
helpers do
  def input_for param, args = {}
  	args = {
  		:type => 'text',
  		:value => h(params[param.to_sym]) || '',
  		:name => param,
  		:id => args[:id] || param
  	}.merge(args)

    "<input #{ args.to_attr }>"
  end

  def radio_for param, args = {}
    args = {
      :type => 'radio'
    }.merge(args)
  
    if params[param.to_sym].to_s == args[:value].to_s
      args.merge!({ :checked => nil })
    end
  
    input_for param, args
  end

  def checkbox_for param, checked_if, args = {}
    args = {
      :type => 'checkbox',
      :value => 'true'
    }.merge(args)
  
    if checked_if || params[param.to_sym] == 'true'
      args.merge!({ :checked => nil })
    end
  
    input_for param, args
  end

  def textarea_for param, args = {}
    args = {
      :name => param,
      :id => args[:id] || param
    }.merge(args)
  
    "<textarea #{ args.to_attr }>#{ h(params[param.to_sym]) || '' }</textarea>"
  end

  def option_for param, args = {}
  
    if params[param.to_sym]
      default = params[param.to_sym].to_s
    elsif args[:default]
      default = args[:default].to_s
    else
      default = ''
    end
  
    text = args.delete(:key)
    args.delete(:default)
  
    if default == args[:value].to_s
      args.merge!({ :selected => nil })
    end
  
    "<option #{ args.to_attr }>#{ text }</option>"
  end

  def select_for param, options, attrib = {}
    # CHANGED: default value can be passed as :default => 'me!'
    opts = ''
  
    if params[param.to_sym]
      p = params[param.to_sym].to_s
    elsif attrib[:default]
      p = attrib[:default].to_s
    else
      p = ''
    end
  
    attrib.delete(:reverse) # don't want this getting turned into an attribute
  
    options.each do |key, val|
      opts << "<option #{ p == val.to_s ? 'selected' : '' } value='#{ val }'>#{ key }</option>"
    end
  
    "<select #{ attrib.to_attr } name='#{ param }' id='#{ param }' size='1'>#{ opts }</select>"
  end
end
