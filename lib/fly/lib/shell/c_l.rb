#
class CL
  require "highline/import"
  
  #**********************************************#
  #                  INSTANCE METHODS            #
  #**********************************************#
    
    # Sets the color scheme (if needed) and retrieves a User object
    def initialize(name)
      set_up_color_scheme
      user_obj = User.first_name_is(name.to_s).first
      attempt_to_launch_shell(user_obj)
    end
    
    # May be overridden in subclass (if needed), otherwise assigns no color scheme.
    def set_up_color_scheme
    end
    
    # Launches main menu routine unless the passed user_object is nil
    def attempt_to_launch_shell(user_obj)
      if user_obj
        launch_shell_controller(user_obj)
      else
        say_invalid_user
      end      
    end
    
    # Instantiates a new ShellController object
    def launch_shell_controller(user_obj)
        ShellController.new(user_obj,self)
    end
    
=begin
    # Complains if the user calls the 'launch_main_menu_routine' method from this 
    # abstract class.
    def launch_main_menu_routine(user_obj)
      FlyError::raise_superclass_error
    end
=end
    
    # Sends an unformatted notice string to the user (may be overridden in subclass to add
    # formatting)
    def say_notice(string)
      HighLine.new.say("\n" + string)
    end
    
    # Sends an unformatted error string to the user (may be overridden in subclass to add
    # formatting)
    def say_error(string)
      HighLine.new.say("\n" + string)
    end    
    
    # Sends a message to the user stating that the username could not be found
    def say_invalid_user
      say_error("Sorry, that username is not valid.")
      return :try_again
    end
    


end