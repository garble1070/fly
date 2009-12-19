# A class allowing the user to manage flight segments easily.
class FlightSegment
  
  attr_reader :start_obj, :end_obj
  attr_accessor :odometer
    
  # Constructor
  def initialize(start_waypoint, end_waypoint)
       @start_obj = start_waypoint
       @end_obj = end_waypoint
       @odometer = 0
  end

  # Returns a string representing the rounded lat/lng coordinates of the starting waypoint
  def start_to_s_rnd
    @start_obj.to_s_rnd
  end
  
  # Returns a string representing the rounded lat/lng coordinates of the ending waypoint
  def end_to_s_rnd
    @end_obj.to_s_rnd
  end
  
  # Returns a string representing the rounded lat/lng coordinates of the starting and the
  # ending waypoints, separated by a pipe character ('|')
  def to_s_rnd
    start_to_s_rnd + "|" + end_to_s_rnd
  end
  

end
