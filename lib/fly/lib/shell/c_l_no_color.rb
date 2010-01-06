# A version of the Command Line (aka CL) class that omits ANSI escape characters
class CLNoColor < CL
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Instantiates a new object and calls the "main_menu" method
    def launch_main_menu_routine(user_obj)
        CLNoColor.new(user_obj).main_menu
    end
        
    # Sends a formatted string to the user that is appropriate for an error
    def say_error(string)
      HighLine.new.say("\nERROR: " + string)
    end    
    
  end
  
  
  
end