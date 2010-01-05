#
class CLWithColor < CL
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    #
    def start_shell(name)
      set_up_color_scheme
      results = User.first_name_is(name.to_s)
      if results.first
        CLWithColor.new(results.first).main_menu
      else
        say_invalid_user
      end
    end
    
    #
    def set_up_color_scheme
      HighLine.color_scheme = HighLine::ColorScheme.new do |cs|
        cs[:notice]          = [ :bold, :green ]
        cs[:error]           = [ :bold, :red ]
      end
    end
    
    #
    def say_notice(string)
      say("\n<%= color('#{string}', :notice ) %>\n")
    end
    
    #
    def say_error(string)
      say("\n<%= color('#{string}', :error ) %>\n")
    end    
    
  end
  
  
end