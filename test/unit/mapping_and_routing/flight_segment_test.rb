require File.dirname(__FILE__) + '/../../test_helper'

class FlightSegmentTest < ActiveSupport::TestCase
  
  def test_basic
    @lax = Airport.find("lax")
    @zrh = Airport.find("zrh")

    @segment = FlightSegment.new(@lax,@zrh)
    assert_not_nil(@segment)
    
    assert_equal(@segment.start_obj,@lax)
    assert_equal(@segment.end_obj,@zrh)
    assert_equal(@segment.odometer,0)
    
    @segment.odometer = 5930
    assert_equal(@segment.odometer,5930)
  end
  
  def test_string_output
    @iad = Airport.find("iad")
    @jfk = Airport.find("jfk")

    @segment = FlightSegment.new(@iad,@jfk)
    assert_not_nil(@segment)
    
    assert_equal(@segment.start_to_s_rnd,"38.945,-77.456")
    assert_equal(@segment.end_to_s_rnd,"40.64,-73.779")
    assert_equal(@segment.to_s_rnd,"38.945,-77.456|40.64,-73.779")
    
  end
  
  
end
