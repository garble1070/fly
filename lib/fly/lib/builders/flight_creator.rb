# Used to create a flight using configuration objects
class FlightCreator < Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Sets the instance variable '@required_param_types'
  def set_required_param_types
    @required_param_types = ["DepartureAirport","ArrivalAirport","Plane"]
  end
  
  # Sets the instance variable '@optional_param_types'
  def set_optional_param_types
    @optional_param_types = @required_param_types.clone
    @optional_param_types << "BoardingDurationInSeconds" << "TaxiDurationInSeconds"
    @optional_param_types << "FlightMiles" << "PaxCount" << "PayloadValueFlc"
    @optional_param_types << "Code"
  end
  
  # Instantiates a new item object; inserts params; returns object
  def generate_new_item_object
    @new_item = Flight.new
    insert_required_params_into_new_item_object
    insert_default_params_into_new_item_object
    insert_optional_params_into_new_item_object(self)
    return @new_item
  end
  
  
  # Inserts required params into new item object
  def insert_required_params_into_new_item_object
    @new_item.plane_id              = plane.id
    @new_item.dep_airport_code      = departure_airport.code
    @new_item.arr_airport_code      = arrival_airport.code
    @new_item.inflight_duration_in_seconds     = calculate_inflight_duration
  end  
  
  # Inserts default params into new item object
  def insert_default_params_into_new_item_object
    payload_value_obj = PayloadValueFlc.new_by_flight_creator_object(self)
    @new_item.boarding_duration_in_seconds     = plane.aircrafttype.boarding_duration_default
    @new_item.taxi_duration_in_seconds         = departure_airport.taxi_duration_default
    @new_item.flight_miles          = route_length_in_miles_not_rounded.to_int
    @new_item.pax_count             = plane.avg_pax_count
    @new_item.payload_value_flc     = payload_value_obj.payload_value_flc
    @new_item.code     = generate_flight_code
  end
  
  #
  def generate_flight_code
    output = plane.airline.code.upcase
    output << random_four_digit_number_from_0001_to_1999
    return output
  end
  
  #
  def random_four_digit_number_from_0001_to_1999
    random_num = rand(2000)+ 1
    string = "000" + random_num.to_s
    output = string.slice(string.length-4,4)
    return output
  end
  
  # Use plane info and route info to caluclate duration of flight
  def calculate_inflight_duration
    flight_distance = DistanceInMiles.new(route_length_in_miles_not_rounded)
    distance_nautical_miles = flight_distance.in_nautical_miles
    speed_knots = plane.avg_speed_knots
    output = distance_nautical_miles.quo(speed_knots) * 3600
    return output.to_int
  end
  
  # Returns an integer representing the route length in miles, rounded to 0 places.
  def route_length_in_miles_not_rounded
    departure_airport.distance_from(arrival_airport)
  end
end

