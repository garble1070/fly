class ShellController
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Constructor.  Takes a valid User object
  def initialize(user_obj,c_l_subclass)
    @c_l_subclass = c_l_subclass
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
  

end