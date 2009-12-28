# Used to create a flight using configuration objects
class FlightCreator < Creator
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Sets the instance variables '@required_param_types'
  def set_expected_param_types
   @required_param_types = ["DepartureAirport","ArrivalAirport","Plane"]
  end
  
  # Instantiates a new item object; inserts params; returns object
  def generate_new_item_object
    @new_item = Flight.new
    insert_required_params_into_new_item_object
    insert_default_params_into_new_item_object
    insert_optional_params_into_new_item_object
    return @new_item
  end

  # Inserts required params into new item object
  def insert_required_params_into_new_item_object
    dep_airport = param_by_classname("DepartureAirport")
    arr_airport = param_by_classname("ArrivalAirport")
    @new_item.plane_id              = param_by_classname("Plane").id
    @new_item.dep_airport_code      = dep_airport.code
    @new_item.arr_airport_code      = arr_airport.code
    @new_item.inflight_duration     = calculate_inflight_duration
  end  
  
  def insert_default_params_into_new_item_object
    @new_item.boarding_duration     = param_by_classname("Plane").aircrafttype.boarding_duration_default
    @new_item.taxi_duration         = dep_airport.taxi_duration_default
    @new_item.pax_count             = param_by_classname("Plane").avg_pax_count
  end
  
  # Use plane info and route info to caluclate duration of flight
  def calculate_inflight_duration
    dep_airport = param_by_classname("DepartureAirport")
    arr_airport = param_by_classname("ArrivalAirport")
    flight_distance = DistanceInMiles.new(dep_airport.distance_from(arr_airport))
    distance_nautical_miles = flight_distance.in_nautical_miles
    speed_knots = param_by_classname("Plane").avg_speed_knots
    output = distance_nautical_miles.quo(speed_knots) * 3600
    return output.to_int
  end

  # Inserts optional params into new item object
  def insert_optional_params_into_new_item_object
    if param_classname_present?("BoardingDurationInSeconds")
      @new_item.boarding_duration     = param_by_classname("BoardingDurationInSeconds").in_seconds
    end
    if param_classname_present?("TaxiDurationInSeconds")
      @new_item.taxi_duration         = param_by_classname("TaxiDurationInSeconds").in_seconds
    end
    if param_classname_present?("PaxCount")  
      @new_item.pax_count   = param_by_classname("PaxCount").pax_count
    end

  end
  
end

# Subclasses 'Airport' to create a 'DepartureAirport' class
class DepartureAirport < Airport
end
 
# Subclasses 'Airport' to create a 'ArrivalAirport' class
class ArrivalAirport < Airport
end
