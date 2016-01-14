# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# This example filter will replace the contents of the default 
# message field with whatever you specify in the configuration.
#
# It is only intended to be used as an example.
class LogStash::Filters::Hexdecode < LogStash::Filters::Base

  # Setting the config_name here is required. This is how you
  # configure this filter from your Logstash config.
  #
  # filter {
  #   example {
  #     message => "My message..."
  #   }
  # }
  #
  config_name "hexdecode"
  
  config :field, :validate => :string, :default => "message"
  
  config :target, :validate => :string
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    original_value = event[@field]
    
    if original_value.is_a?(String)
	    if (original_value.length == 0)
		    event[(@target||@field)] = original_value
	    else
		    arr = Array(original_value.gsub('00',''))
        event[(@target||@field)] = arr.pack('H*').force_encoding('utf-8')
	    end
    else
      raise LogStash::ConfigurationError, "Only String can be hexdecoded. field:#{@field} is of type = #{original_value.class}"
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Example
