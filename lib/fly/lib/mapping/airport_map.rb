class AirportMap < StaticMap
  
  # Constructor.  Sets default width and height for the static image.
  def initialize(airline)
    @airline = airline
    @ops_airports = airline.ops_airports
    @map_width = 450
    @map_height = 300
  end
  
  
  # Returns the complete query string for the Google Maps static API
  def complete_url
    callback = lambda {}
    complete_url_generator(&callback)
  end
  
  # Inserts marker query param data for the airports map
  def insert_basic_params_for_map_subclass
    @ops_airports.each do |airport|
      @query.add_param("markers",airport_marker(airport).to_s_rnd)
    end
  end
  
  # creates a MapMarker object with the first letter of the airport code
  def airport_marker(airport)
    marker = generic_marker(airport)
    marker.label = airport.code[0,1]
    return marker
  end
  
end
