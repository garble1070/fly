class FlightRouting
  
  attr_accessor :routing
  attr_reader :distance, :heading, :dep_airport
  
  # Constructor.  Takes any two objects that have @lat and @lng instance variables as arguments.
  def initialize(dep_airport=nil, arr_airport=nil)
    @dep_airport = dep_airport
    @arr_airport = arr_airport
    @segment_count = 0
    if dep_airport && arr_airport
      @original_pair = [dep_airport,arr_airport]
      @routing = [@original_pair]
      @distance = dep_airport.distance_from(arr_airport)
      @heading = dep_airport.heading_to(arr_airport)
      @segment_count = 1
    end
  end
  
  # Divides the original routing up into an appropriate number of equally-sized chunks, and returns
  # an array of segments
  def generate_complex_route
    iterator_count.times do
      @routing = split_main_array(@routing)
    end
    output = create_output_array
    @routing = [@original_pair]
    return output
  end
  
  # Returns a Fixnum representing the number of segments that are needed to produce a route path
  # with an adequate level of granularity (important for curved flight routes)
  def iterator_count
    number = case 
      when @distance >= 4800 then 5
      when @distance >= 2400 then 4
      when @distance >= 1200 then 3
      when @distance >= 600 then 2
      else 1
    end   
    return number
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