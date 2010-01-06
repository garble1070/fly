class ShellController
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Constructor.  Takes a valid User object
  def initialize(user_obj,c_l_subclass_inst)
    @shell_view = ShellView.new(c_l_subclass_inst)
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
  
  #
  def acquire_new_plane
    aircrafttype = @shell_view.ask_which_aircrafttype_to_buy
    if @airline.acquire_new_plane(aircrafttype)
      @shell_view.say_transaction_success
      @shell_view.say_account_balance
    else
      @shell_view.say_transaction_failure
    end
  end

end