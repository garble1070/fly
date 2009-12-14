require File.dirname(__FILE__) + '/../../test_helper'

class FlightSegmentTest < ActiveSupport::TestCase
  
  def test_basic
    @lax = Airport.find("lax")
    assert_not_nil(@lax)
    
    @zrh = Airport.find("zrh")
    assert_not_nil(@zrh)
    
    @segment = FlightSegment.new(@lax,@zrh)
    assert_not_nil(@segment)
    
    assert_equal(@segment.start_obj,@lax)
    assert_equal(@segment.end_obj,@zrh)
    assert_equal(@segment.odometer,0)
    
    @segment.odometer = 5930
    assert_equal(@segment.odometer,5930)
  end
  
  
end
