# A class that holds all pertinent information relative to the routing of a flight
class FlightPlan
  
  attr_reader :dep_airport, :arr_airport, :distance, :heading, :segment_series
  
  class << self
    # Allows the user to instantiate a new FlightPlan object and trigger the immediate
    # generation of the segment_series
    def new_with_segment_series(dep_airport,arr_airport)
      new_obj = self.new(dep_airport,arr_airport)
      new_obj.generate_granular_segment_series
      return new_obj
    end
    
  end
  
  # Constructor.  Takes any two objects that have @lat and @lng instance variables as arguments.
  def initialize(dep_airport=nil, arr_airport=nil)
    @dep_airport = dep_airport
    @arr_airport = arr_airport
    if dep_airport && arr_airport
      set_distance_and_heading
    end
  end
  
  # Calculates and sets values for '@distance' and '@heading' instance variables
  def set_distance_and_heading
    @distance = dep_airport.distance_from(arr_airport)
    @heading = dep_airport.heading_to(arr_airport)
  end
  
  # Creates a new, granular SegmentSeries
  def generate_granular_segment_series
    reset_routing
    multiply_segments
  end
  
  # Resets the values for '@segment_series' and '@segment_count' to the original one-segment route
  def reset_routing
    @segment_series = SegmentSeries.new
    @segment_series << FlightSegment.new(@dep_airport,@arr_airport)
  end
  
  # Divides the existing route into smaller, equallly-sized chunks
  def multiply_segments
    iterator_count.times do
      split_series(@segment_series)
    end
  end
  
  # Returns a Fixnum representing the number of segments that are needed to produce a route path
  # with an adequate level of granularity (important for curved flight routes)
  def iterator_count
    case 
      when @distance >= 4800 then 5
      when @distance >= 2400 then 4
      when @distance >= 1200 then 3
      when @distance >= 600 then 2
    else 1
    end   
  end
  
  # Takes a segment_series collection and splits it into chunks, each half in size of the
  # previous segment, and stores it in the '@segment_series' instance variable
  def split_series(source_series)
    output_series = SegmentSeries.new
    source_series.each do |segment|
      output_series.concat(split_segment(segment))
    end
    @segment_series = output_series
    calculate_odometer_values
  end
  
  # Takes a segment and returns two smaller segments wrapped in a SegmentSeries object
  def split_segment(source_segment)
    start_obj = source_segment.start_obj
    end_obj = source_segment.end_obj
    mid_obj = start_obj.midpoint_to(end_obj)
    segment1 = FlightSegment.new(start_obj, mid_obj)
    segment2 = FlightSegment.new(mid_obj, end_obj)
    return SegmentSeries.new << segment1 << segment2
  end
  
  # Walks the '@segment_series' series, inserting the 'odometer value' into each FlightSegment.
  def calculate_odometer_values
    current_odometer = 0
    segment_length = @distance.quo(@segment_series.length)
    @segment_series.each do |segment|
      current_odometer += segment_length
      segment.odometer = current_odometer
    end
  end  
  
end