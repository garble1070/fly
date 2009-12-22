require File.dirname(__FILE__) + '/../../test_helper'

class FlightSegmentTest < ActiveSupport::TestCase
  
  def test_basic
    load_instance_vars

    @segment = FlightSegment.new(@lax,@zrh)
    assert_not_nil(@segment)
    
    assert_equal(@segment.start_obj,@lax)
    assert_equal(@segment.end_obj,@zrh)
    assert_equal(@segment.odometer,0)
    
    @segment.odometer = 5930
    assert_equal(@segment.odometer,5930)
  end
  
  def test_string_output
    load_instance_vars

    @segment = FlightSegment.new(@iad,@jfk)
    assert_not_nil(@segment)
    
    assert_equal(@segment.start_to_s_rnd,"38.945,-77.456")
    assert_equal(@segment.end_to_s_rnd,"40.64,-73.779")
    assert_equal(@segment.to_s_rnd,"38.945,-77.456|40.64,-73.779")
    
  end
  
  
end
