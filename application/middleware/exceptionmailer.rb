require 'pony'
require 'erb'

module Rack
  class ExceptionMailer
    
    def initialize(app, options)
      @app           = app
      @to            = Array(options[:to]) # could be an array
      @from          = options[:from]      # should be string
      @subject       = options[:subject] || "Error Caught in Rack Application" # again, a string
      @template      = ERB.new(TEMPLATE) # the template built in here (non-mutable { for the moment })
      @html_template = ERB.new(HTML_TEMPLATE) # the same template in HTML
    end
  
    def call(env)
      status, headers, body =
        begin
          @app.call(env)
        rescue => boom
          # don't allow exceptions from send_notification to propogate
          begin
            send_notification boom, env
          rescue
            # just ignore it. we only care about the initial exception
          end
          
          raise
        end
      send_notification env['mail.exception'], env if env['mail.exception']
      [status, headers, body]
    end
    
    def send_notification(exception, env)
      body = @template.result(binding) # not sure about this (binding) thing
      html_body = @html_template.result(binding)
      
      # loop through each :to address and fire off an email with the error
      @to.each do |to|
        Pony.mail :to => to, :from => @from, :subject  => @subject, :body => body, :html_body => html_body
      end
    end
    
    def extract_body(env)
      if io = env['rack.input']
        io.rewind if io.respond_to?(:rewind)
        io.read
      end
    end
    
    
    TEMPLATE = (<<-'EMAIL').gsub(/^ {4}/, '')
    A <%= exception.class.to_s %> occured: <%= exception.to_s %>
    
    <% if exception.respond_to?(:backtrace) %>
    ===================================================================
    Backtrace:
    ===================================================================

      <%= exception.backtrace.join("\n  ") %>
    <% end %>

    ===================================================================
    Rack Environment:
    ===================================================================

      PID:                     <%= $$ %>
      PWD:                     <%= Dir.getwd %>

      <%= env.to_a.sort{|a,b| a.first <=> b.first}.map{ |k,v| "%-25s%p" % [k+':', v] }.join("\n  ") %>
    EMAIL
    
    HTML_TEMPLATE = (<<-'EMAIL').gsub(/^ {4}/, '')
    <h2>A <%= exception.class.to_s %> occured: <%= exception.to_s %></h2>
    
  <% if exception.respond_to?(:backtrace) %>
    <h3>Backtrace:</h3>
    <%= exception.backtrace[0,10].join("<br />") %>
  <% end %>

    <h3>Rack Environment:</h3>
    <table>
      <tr>
        <td><b>PID:</b></td> <td><%= $$ %></td>
      </tr>
      <tr>
        <td><b>PWD:</b></td><td><%= Dir.getwd %></td>
      </tr>
    <%= env.to_a.sort { |a,b| a.first <=> b.first}.map { |k, v| "<tr><td><b>#{k}</b></td><td>#{v}</td></tr>" }.join(" ") %>
    </table>
    EMAIL
  end
end
