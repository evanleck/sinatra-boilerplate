class Hash
  # converts a Hash into an HTML attribute where the key is the attribute and the value is the value.
  #   { :id => 'two', :class => 'me', :required => true }.to_attr
  # yields
  #   id="two" class="me" required
  #
  # Really handy for generating markup
  def to_attr
    collect do |key, value|
      if value.is_a? Hash
        value.collect do |k, v|
          "#{key}-#{k}='#{v}'"
        end
      else
        value.is_a?(TrueClass) ? key.to_s : "#{key}='#{value}'"
      end
    end.join(' ').chomp
  end
end
