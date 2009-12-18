class FlightMap < StaticMap
  
  # Constructor.  Sets default width and height for the static image.
  def initialize(dep_airport, arr_airport)
    @dep_airport = dep_airport
    @arr_airport = arr_airport
    @flight_plan = FlightPlan.new_with_all_data(dep_airport, arr_airport)
    @map_width = 450
    @map_height = 300
  end
  
  # Assigns arguments for width and height to the appropriate instance variables
  def set_size(width,height)
    @map_width = width
    @map_height = height
  end
  
  # Returns the complete query string for the Google Maps static API
  def complete_url(distance_so_far=0)
    @query = QueryCollectionNonExclusiveKey.new
    insert_basic_params
    @distance_so_far = cap_max_distance(distance_so_far)
    if @distance_so_far > 0
      insert_inflight_params
    end
    @query.output
  end
  
  # Inserts marker and path query param data for the inflight route
  def insert_basic_params
    @query.add_param("maptype","terrain")
    @query.add_param("format","jpg")
    @query.add_param("sensor","false")
    @query.add_param("size","#{@map_width}x#{@map_height}")
    @query.add_param("key",GOOGLE_MAPS_STATIC_API_KEY)
    @query.add_param("markers",start_marker.to_s_rnd)
    @query.add_param("markers",end_marker.to_s_rnd)
    @query.add_param("path",scheduled_path.to_s_rnd)
  end
  
  # Returns the distance traveled up to the present, capped at the total route length
  def cap_max_distance(distance_so_far)
    if distance_so_far > @flight_plan.distance 
      @flight_plan.distance 
    else 
      distance_so_far
    end
  end
  
  # Inserts marker and path query param data for the inflight route
  def insert_inflight_params
    calculate_inflight_data
    @query.add_param("markers",inflight_marker.to_s_rnd)
    @query.add_param("path",inflight_path.to_s_rnd)
  end
  
  # Calculates the '@current_position' (Geokit Latlng object) and '@flight_plan_to_current_position' instance
  # variables
  def calculate_inflight_data
    @current_position = @dep_airport.endpoint(@flight_plan.heading,@distance_so_far)
    @flight_plan_to_current_position = FlightPlan.new_with_all_data(@dep_airport,@current_position)
  end
  
  # Returns an object that may be used to set the marker representing the start of the scheduled
  # route
  def start_marker
    marker = MapMarker.new(@dep_airport,"D")
    marker.color = "red"
    return marker
  end
  
  # Returns an object that may be used to set the marker representing the aircraft's inflight position
  def inflight_marker
    marker = MapMarker.new(@current_position)
    marker.color = "yellow"
    return marker
  end
  
  # Returns an object that may be used to set the marker representing the end of the scheduled
  # route
  def end_marker
    marker = MapMarker.new(@arr_airport,"A")
    marker.color = "green"
    return marker
  end
  
  # Returns a string that may be used to create a path representing the aircraft's scheduled 
  # trajectory
  def scheduled_path
    path = MapPath.new(@flight_plan)
    path.color = "0x555555AA"
    return path
  end
  
  # Returns a string that may be used to create a path representing the aircraft's trajectory up
  # to it's current position as specified in the method call to 'generate_url'
  def inflight_path
    path = MapPath.new(@flight_plan_to_current_position)
    path.color = "0xFFFF00FF"
    path.weight = 6
    return path
  end
  
  
end
