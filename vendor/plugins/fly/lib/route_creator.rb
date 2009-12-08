# Used to create a route using configuration objects
class RouteCreator < Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
    
  # Sets the instance variables '@required_param_types'
  def set_expected_param_types
    @required_param_types = ["DepartureAirport","ArrivalAirport","DistanceInMiles"]
  end
    
  # Instantiates a new item object; inserts params; returns object
  def generate_new_item_object
    @new_item = Route.new
    insert_required_params_into_new_item_object
    insert_optional_params_into_new_item_object
    return @new_item
  end

  # Inserts required params into new item object
  def insert_required_params_into_new_item_object
    @new_item.dep_airport_code   = param_by_classname("DepartureAirport").code
    @new_item.arr_airport_code   = param_by_classname("ArrivalAirport").code
    @new_item.distance_miles = param_by_classname("DistanceInMiles").quantity
  end
  
  # Inserts optional params into new item object
  def insert_optional_params_into_new_item_object
    if param_classname_present?("Aircrafttype")
      @new_item.aircrafttype_id = param_by_classname("Aircrafttype").id
    end
  end
  
end


class DepartureAirport < Airport
end

class ArrivalAirport < Airport
end
