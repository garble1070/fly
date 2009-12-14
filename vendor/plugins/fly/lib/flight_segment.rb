class FlightSegment
  
  attr_reader :start_obj, :end_obj
  attr_accessor :odometer
    
  def initialize(start_waypoint, end_waypoint)
       @start_obj = start_waypoint
       @end_obj = end_waypoint
       @odometer = 0
  end

end