# A version of the Command Line (aka CL) class that uses ANSI escape characters to
# provide color text to the terminal
class CLWithColor < CL
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Establishes the ANSI presentation parameters for this session
    def set_up_color_scheme
      HighLine.color_scheme = HighLine::ColorScheme.new do |cs|
        cs[:notice]          = [ :bold, :green ]
        cs[:error]           = [ :bold, :red ]
      end
    end
    
    # Sends a formatted string to the user that is appropriate for a notice
    def say_notice(string)
      HighLine.new.say("\n<%= color('#{string}', :notice ) %>\n")
    end
    
    # Sends a formatted string to the user that is appropriate for an error
    def say_error(string)
      HighLine.new.say("\n<%= color('#{string}', :error ) %>\n")
    end    
    
  end
  
  
end