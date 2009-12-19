# A class that holds FlightSegment objects
class SegmentSeries < Array
  
  # Constructor
  def initialize(*args, &block)
    super(*args, &block)
  end
  
  # Adds FlightSegment object to end of SegmentSeries
  def << (arg)
    super(arg)
  end
  
  # Adds all FlightSegments in the SegmentSeries object provided in the argument to the end of
  # the existing (i.e. 'self') SegmentSeries
  def concat(arg)
    super(arg)
  end
end