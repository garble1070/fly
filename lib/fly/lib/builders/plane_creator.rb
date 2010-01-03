# Used to create a plane using configuration objects
class PlaneCreator < Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Sets the instance variable '@required_param_types'
  def set_required_param_types
    @required_param_types = ["Aircrafttype","Airline","Airport"]
  end
  
  # Sets the instance variable '@optional_param_types'
  def set_optional_param_types
    @optional_param_types = @required_param_types.clone
    @optional_param_types << "Name" << "StartingPaxCount" << "StartingMilesCount"
  end
  
  # Instantiates a new item object; inserts params; returns object
  def generate_new_item_object
    @new_item = Plane.new
    insert_required_params_into_new_item_object
    insert_optional_params_into_new_item_object
    return @new_item
  end
  
  # Inserts required params into new item object
  def insert_required_params_into_new_item_object
    @new_item.airline_id             = airline.id
    @new_item.starting_airport_code  = airport.code
    @new_item.aircrafttype_id        = aircrafttype.id
    @new_item.avg_pax_count          = aircrafttype.avg_pax_count_default
    @new_item.avg_speed_knots        = aircrafttype.avg_speed_knots_default
    @new_item.range_miles            = aircrafttype.range_miles_default 
    @new_item.acquisition_cost       = aircrafttype.cost     
  end
    
  # Inserts optional params into new item object
  def insert_optional_params_into_new_item_object
    if name
      @new_item.name                 = name.to_s
    end
    if starting_pax_count
      @new_item.starting_pax_count   = starting_pax_count.quantity
    end
    if starting_miles_count
      @new_item.starting_miles_count = starting_miles_count.quantity
    end    
  end
  
end

