#
class CL
  require "highline/import"
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    #
    def method_missing(name, *args)
      if methods.include?(name.to_s)
        super(name,*args)
      else
        start_shell(name, *args)
      end
    end
    
    #
    def start_shell(name, *args)
      set_up_color_scheme
      results = User.first_name_is(name.to_s)
      if results.first
        CL.new(results.first).main_menu
      else
        say_error("Sorry, that username is not valid.")
        return :try_again
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
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  def method_missing(name,*args)
    if name.to_s.slice(0,3) == "say"
      self.class.send(name,*args)
    end
  end
  
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
  
  
  def initialize(user_obj)
    @user = user_obj  
    @airline = @user.my_airline
    @items_to_update = ["my_account","all_planes","active_flights","ops_airports"]
    @items_to_update.concat(["flight_segment_tally","pax_count_tally","flight_miles_tally"])
    update
  end
  
  #
  def update
    @items_to_update.each do |string|
      self.instance_variable_set("@#{string}",@airline.send(string))
    end
    return self
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