class StaticMap
  
end

class FlightMap < StaticMap
  
  # Constructor.  Sets default width and height for the static image.
  def initialize(flight_routing_obj)
    @route = flight_routing_obj.generate_complex_route
    @heading = flight_routing_obj.heading
    @dep_airport = flight_routing_obj.dep_airport
    @query = QueryCollection.new
    @width = 450
    @height = 300
  end
  
  # Assigns arguments for width and height to the appropriate instance variables
  def set_size(width,height)
    @width = width
    @height = height
  end
  
  # Returns the complete query string for the Google Maps static API
  def generate_url(distance_so_far=0)
    @distance_so_far = distance_so_far
    @start_pair = create_pair_string(@route[0],:start)
    @query.add_param("maptype","terrain")
    @query.add_param("format","jpg")
    @query.add_param("sensor","false")
    @query.add_param("size","#{@width}x#{@height}")
    @query.add_param("key","ABQIAAAAHjDfn4JyllVUPtyJ31qLhhSjmO-kHhwqX2l12pfya7ICKXzFqhRq3QRp0Ql03P59GaKmwMasDuskrA")
    @query.add_param("markers",start_marker_string)
    @query.add_param("markers",end_marker_string)
    @query.add_param("path",scheduled_path_string)
    if @distance_so_far > 0
      insert_inflight_params
    end
    @query.output
  end
  
  # Inserts marker and path query param data for the inflight route
  def insert_inflight_params
    calculate_inflight_data
    @query.add_param("markers",inflight_marker_string)
    @query.add_param("path",inflight_path_string)
  end
  
  # Returns a string formatted as "<lat>,<lng>"
  def create_pair_string(segment,position=:end)
    point_lat = segment["#{position}_lat".to_sym].for_output
    point_lng = segment["#{position}_lng".to_sym].for_output
    return point_lat + "," + point_lng
  end
  
  # Returns a string that may be used to set the marker representing the start of the scheduled
  # route
  def start_marker_string
    "color:red|label:D|" + @start_pair
  end
  
  # Returns a string that may be used to set the marker representing the aircraft's inflight position
  def inflight_marker_string
    "color:yellow|" + @inflight_pair
  end
  
  # Returns a string that may be used to set the marker representing the end of the scheduled
  # route
  def end_marker_string
    count = @route.length - 1
    "color:green|label:A|" + create_pair_string(@route[count],:end)
  end
  
  # ..
  def scheduled_path_string
    "color:0x555555AA|weight:5|" + path_string(@route)
  end
  
  # Returns a string that may be used to create a path representing the aircraft's trajectory up
  # to it's current position as specified in the method call to 'generate_url'
  def inflight_path_string
    "color:0xFFFF00FF|weight:5|" + path_string(@inflight_route)
  end
  
  # Returns a string that may be used to create a path representing the aircraft's scheduled 
  # trajectory
  def path_string(route)
    output = (@start_pair + "|")
    route.each do |segment|
      output << (create_pair_string(segment,:end) + "|")
    end
    return output.chop
  end
  
  # Returns a string representing the flight's current position (as lat/lng point) 
  def calculate_inflight_data
    @inflight_route = []
    waypoint = @dep_airport.endpoint(@heading,@distance_so_far)
    @inflight_pair = waypoint.lat.for_output + "," + waypoint.lng.for_output
  end
  
end

# Extends class to include the 'for_output' method
class Float
  
  # Rounds a floating point number to 3 digits and returns it as a string
  def for_output
    self.round(3).to_s
  end
end
