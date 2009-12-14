require File.dirname(__FILE__) + '/../../test_helper'

class SegmentSeriesTest < ActiveSupport::TestCase
  
  def test_basic
    @lax = Airport.find("lax")
    @iad = Airport.find("iad")
    @jfk = Airport.find("jfk")
    @cdg = Airport.find("cdg")
    @zrh = Airport.find("zrh")
    
    @segment0 = FlightSegment.new(@lax,@iad)
    assert_not_nil(@segment0)
    
    @segment1 = FlightSegment.new(@iad,@jfk)
    assert_not_nil(@segment1)

    @segment2 = FlightSegment.new(@jfk,@cdg)
    assert_not_nil(@segment2)

    @segment3 = FlightSegment.new(@cdg,@zrh)
    assert_not_nil(@segment3)

    @series1 = SegmentSeries.new
    assert_not_nil(@series1)
    @series1 << @segment0
    @series1 << @segment1
    
    assert_equal(@series1[0],@segment0)
    assert_equal(@series1[1],@segment1)

    @series2 = SegmentSeries.new
    @series2 << @segment2
    @series2 << @segment3
    @series1.concat(@series2)
    
    assert_equal(@series1[2],@segment2)
    assert_equal(@series1[3],@segment3)

  end
  
  
end
