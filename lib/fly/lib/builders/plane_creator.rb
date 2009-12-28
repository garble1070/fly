# Used to create a plane using configuration objects
class PlaneCreator < Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Sets the instance variables '@required_param_types'
  def set_expected_param_types
    @required_param_types = ["Aircrafttype","Airline","Airport"]
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
    @new_item.airline_id             = param_by_classname("Airline").id
    @new_item.starting_airport_code  = param_by_classname("Airport").code
    @new_item.aircrafttype_id        = param_by_classname("Aircrafttype").id
    @new_item.avg_pax_count           = param_by_classname("Aircrafttype").avg_pax_count_default
    @new_item.avg_speed_knots        = param_by_classname("Aircrafttype").avg_speed_knots_default
    @new_item.range_miles            = param_by_classname("Aircrafttype").range_miles_default 
    @new_item.acquisition_cost       = param_by_classname("Aircrafttype").cost     
  end
  
  # Inserts optional params into new item object
  def insert_optional_params_into_new_item_object
    if param_classname_present?("String")
      @new_item.name                 = param_by_classname("String")
    end
    if param_classname_present?("StartingPaxCount")
      @new_item.starting_pax_count   = param_by_classname("StartingPaxCount").starting_pax_count
    end
    if param_classname_present?("StartingMilesCount")
      @new_item.starting_miles_count = param_by_classname("StartingMilesCount").starting_miles_count
    end    
  end
  
end

