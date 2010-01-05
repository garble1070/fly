#
class CLNoColor < CL
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    #
    def start_shell(name)
      results = User.first_name_is(name.to_s)
      if results.first
        CLNoColor.new(results.first).main_menu
      else
        say_invalid_user
      end
    end
    
    #
    def say_notice(string)
      say(string)
    end
    
    #
    def say_error(string)
      say("ERROR: " + string)
    end    
    
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  
end