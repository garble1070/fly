#
class CommandLineReport

  #
  def initialize(airline_obj)
    @airline = airline_obj  
    @items_to_update = ["my_account","all_planes","active_flights","ops_airports"]
    @items_to_update << "flight_segment_tally" << "pax_count_tally" << "flight_miles_tally"
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
    
  end
  
  
end