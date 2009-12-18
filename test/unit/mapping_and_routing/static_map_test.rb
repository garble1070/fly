require File.dirname(__FILE__) + '/../../test_helper'

class StaticMapTest < ActiveSupport::TestCase
 
 def test_basic
   @lax = Airport.find("lax")
   @zrh = Airport.find("zrh")
   
   @flight_map = FlightMap.new(@lax,@zrh)
   assert_not_nil(@flight_map)
   
   assert_equal(@flight_map.map_width,450)
   assert_equal(@flight_map.map_height,300)
   @flight_map.set_size(480,240)
   assert_equal(@flight_map.map_width,480)
   assert_equal(@flight_map.map_height,240)
   
 end
end
