# A version of the Command Line (aka CL) class that omits ANSI escape characters
class CLNoColor < CL
  
  #**********************************************#
  #                  INSTANCE METHODS            #
  #**********************************************#
  

    # Sends a formatted string to the user that is appropriate for an error
    def say_error(string)
      HighLine.new.say("\nERROR: " + string)
    end    
    
  
  
end