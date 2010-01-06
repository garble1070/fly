#
class CL
  require "highline/import"
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Sets the color scheme (if needed) and retrieves a User object
    def method_missing(name, *args)
      set_up_color_scheme
      user_obj = User.first_name_is(name.to_s).first
      attempt_to_launch_shell(user_obj)
    end
    
    # Launches main menu routine unless the passed user_object is nil
    def attempt_to_launch_shell(user_obj)
      if user_obj
        launch_main_menu_routine(user_obj)
      else
        say_invalid_user
      end      
    end
    
    # May be overridden in subclass (if needed), otherwise assigns no color scheme.
    def set_up_color_scheme
    end
    
    # Complains if the user calls the 'launch_main_menu_routine' method from this 
    # abstract class.
    def launch_main_menu_routine(user_obj)
      FlyError::raise_superclass_error
    end
    
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
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Constructor.  Takes a valid User object
  def initialize(user_obj)
    @user = user_obj  
    @airline = @user.my_airline
    @items_to_update = ["my_account","all_planes","active_flights","ops_airports"]
    @items_to_update.concat(["flight_segment_tally","pax_count_tally","flight_miles_tally"])
    update
  end
  
  # Retrieves updated values from the database and puts them into the appropriate instance 
  # variables
  def update
    @items_to_update.each do |string|
      self.instance_variable_set("@#{string}",@airline.send(string))
    end
    return self
  end
  
  # Main looping method that allows the user to choose top-level actions
  def main_menu
    17.times {output_blank_line}
    say_notice("Welcome to the Fly NextGen game!")
    loop do
      choose do |menu|
        menu.prompt = "\nWhat would you like to do?\n"
        
        menu.choice("see overview of your airline and account") { self.output }
        menu.choice("schedule a flight") { say("ok\n") }
        menu.choice("quit program") { exit }
      end
    end
  end
  
  # Looks for method calls that begin with "say_" and hands them off to the class object
  def method_missing(name,*args)
    if name.to_s.slice(0,4) == "say_"
      self.class.send(name,*args)
    end
  end
  
  
  #
  def output
    output_account_balance
    output_ops_airports
    output_active_flights
    output_activity_to_date
    10.times {output_blank_line}; :ok
  end
  
  def output_account_balance
    output = "ACCOUNT BALANCE:  ".ljust(18) + @my_account.balance.to_s
    puts output
    output_blank_line
  end
  #
  def output_ops_airports
    output = "YOUR AIRPORTS:".ljust(18)
    @ops_airports.each do |airport_obj|
      output << airport_obj.code.upcase + " | "
    end
    if output.length > 18
      output = output.slice(0,output.length-3)
    end
    puts output
    output_blank_line
  end
  
  #
  def output_active_flights
    puts "YOUR FLIGHTS:".ljust(18) + "ID     FROM  TO    STATUS"
    if @active_flights.length == 0
      output = "".ljust(18)
      output << "<no active flights>"
      puts output
    end
    @active_flights.each do |flight_obj|
      output = "".ljust(18)
      output << flight_obj.flight_identifier + " "
      output << flight_obj.dep_airport.code.upcase + "   "
      output << flight_obj.arr_airport_code.upcase + "   "
      output << flight_obj.current_status.to_s
      puts output
    end
    output_blank_line
  end
  
  #
  def output_activity_to_date
    output = "ACTIVITY TO DATE:".ljust(18)
    output << @flight_segment_tally.to_s + " segments | "
    output << @pax_count_tally.to_s + " passengers | "
    output << @flight_miles_tally.to_s + " miles flown" 
    puts output
    output_blank_line
  end
  
  #
  def output_blank_line
    say("\n")
  end
  
end