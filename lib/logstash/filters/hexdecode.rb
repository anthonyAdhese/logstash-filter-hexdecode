# encoding: utf-8
require "logstash/filters/base"
require "logstash/namespace"

# The hexdecode filter is for decoding hexencoded string into readable strings.
class LogStash::Filters::Hexdecode < LogStash::Filters::Base

  config_name "hexdecode"
  
  # The name of the field containing the hexencoded string
  config :field, :validate => :string, :default => "message"
  
  #The name of the field in which the decoded string will end up in.
  config :target, :validate => :string
  

  public
  def register
    # Add instance variables 
  end # def register

  public
  def filter(event)

    original_value = event[@field]
    return if original_value.nil?
    
    if original_value.is_a?(String)
	    if (original_value.length == 0)
		    event[@target] = original_value
	    else
		    arr = Array(original_value.gsub('00',''))
        event[@target] = arr.pack('H*').force_encoding('utf-8')
	    end
    else
      raise LogStash::ConfigurationError, "Only String can be hexdecoded. field:#{@field} is of type = #{original_value.class}"
    end

    # filter_matched should go in the last line of our successful code
    filter_matched(event)
  end # def filter
end # class LogStash::Filters::Hexdecode
