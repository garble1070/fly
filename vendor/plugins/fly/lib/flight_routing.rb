class FlightRouting
  
  attr_accessor :routing
  
  # Constructor.  Takes any two objects that have @lat and @lng instance variables as arguments.
  def initialize(dep_airport=nil, arr_airport=nil)
    @dep_airport = dep_airport
    @arr_airport = arr_airport
    @segment_count = 0
    if @dep_airport && @arr_airport
      @start_latlng = Geokit::LatLng.new(dep_airport.lat, dep_airport.lng)
      @end_latlng = Geokit::LatLng.new(arr_airport.lat, arr_airport.lng)
      @original_pair = [@start_latlng,@end_latlng]
      @routing = [@original_pair]
      @segment_count += 1
    end
  end
  
  # Divides the original routing up into 16 equally-sized chunks
  def generate_complex_route
    @routing = split_main_array(@routing)
    @routing = split_main_array(@routing)
    @routing = split_main_array(@routing)
    @routing = split_main_array(@routing)
    output = create_output_array
    @routing = [@original_pair]
    return output
  end
  
  # Formats the route into an array of hashes, each one representing a route segment.
  def create_output_array
    output = []
    original_distance = @dep_airport.distance_from(@arr_airport)
    segment_length = original_distance.quo(@segment_count)
    odometer = segment_length
    @routing.collect do |pair|
      hash = {:start_lat => pair[0].lat,
              :start_lng => pair[0].lng,
              :end_lat => pair[1].lat,
              :end_lng => pair[1].lng,
              :odometer => odometer}
      output.push(hash)
      odometer += segment_length
    end
    return output
  end
  
  # Takes the @routing array of route segments and splits it into chunks, each half in size of the
  # previous segment
  def split_main_array(main_array)
    output_array = []
    @segment_count = 0
    main_array.each do |pair|
      double_pair = split_segment(pair)
      output_array.push(double_pair[0])
      @segment_count += 1
      output_array.push(double_pair[1])
      @segment_count += 1
    end
    return output_array
  end
  
  # Takes a segment and returns two smaller segments wrapped in an outer array
  def split_segment(array)
    start_point = array[0]
    end_point = array[1]
    mid_point = start_point.midpoint_to(end_point)
    return [[start_point, mid_point], [mid_point,end_point]]
  end
  
  
end