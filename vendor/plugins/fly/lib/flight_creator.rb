# Used to create a flight using configuration objects
class FlightCreator < Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Sets the instance variables '@required_param_types'
  def set_expected_param_types
    @required_param_types = ["Route","Plane"]
  end
  
  # Instantiates a new item object; inserts params; returns object
  def generate_new_item_object
    @new_item = Flight.new
    insert_required_params_into_new_item_object
    insert_optional_params_into_new_item_object
    return @new_item
  end

  # Inserts required params into new item object
  def insert_required_params_into_new_item_object
    @new_item.plane_id              = param_by_classname("Plane").id
    @new_item.route_id              = param_by_classname("Route").id
    @new_item.boarding_duration     = param_by_classname("Plane").aircrafttype.boarding_duration_default
    @new_item.taxi_duration         = param_by_classname("Route").dep_airport.taxi_duration_default
    @new_item.inflight_duration     = calculate_inflight_duration
    @new_item.maintenance_duration  = param_by_classname("Plane").airline.maintenance_duration_default
  end  
  
  # Use plane info and route info to caluclate duration of flight
  def calculate_inflight_duration
    distance_miles = param_by_classname("Route").distance_miles
    speed_mph = param_by_classname("Plane").avg_speed
    distance_miles.quo(speed_mph) * 3600
  end

  # Inserts optional params into new item object
  def insert_optional_params_into_new_item_object
    if param_classname_present?("BoardingDurationInSeconds")
      @new_item.boarding_duration     = param_by_classname("BoardingDurationInSeconds").duration_in_seconds
    end
    if param_classname_present?("TaxiDurationInSeconds")
      @new_item.taxi_duration         = param_by_classname("TaxiDurationInSeconds").duration_in_seconds
    end
    if param_classname_present?("InflightDurationInSeconds")
      @new_item.inflight_duration     = param_by_classname("InflightDurationInSeconds").duration_in_seconds
    end
    if param_classname_present?("MaintenanceDurationInSeconds")
      @new_item.maintenance_duration  = param_by_classname("MaintenanceDurationInSeconds").duration_in_seconds
    end    
  end
  
end

