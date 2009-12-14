require File.dirname(__FILE__) + '/../../test_helper'

class FlightRoutingTest < ActiveSupport::TestCase
  
  def test_all
    @lax = Airport.find("lax")
    assert_not_nil(@lax)
    
    @zrh = Airport.find("zrh")
    assert_not_nil(@zrh)
    
    @route = FlightRouting.new(@lax,@zrh)
    assert_not_nil(@route)
    
    assert_equal(@route.distance.round(3),5930.850)
    assert_equal(@route.heading.round(3),32.800)
    
#    @complex_route = @routing_obj.complex_route
#    assert_not_nil(@complex_route)
  end
  
  
end
