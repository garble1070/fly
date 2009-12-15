require File.dirname(__FILE__) + '/../../test_helper'

class MapMarkerTest < ActiveSupport::TestCase
   def test_basic
     @jfk = Airport.find("jfk")
     @marker = MapMarker.new(@jfk)
     assert_not_nil(@marker)
     
     assert_nil(@marker.label)
     assert_equal(@marker.color,"white")
     @marker.color = "red"
     assert_equal(@marker.color,"red")
     assert_equal(@marker.color_to_s,"color:red|")
     assert_equal(@marker.label_to_s,"")
     assert_equal(@marker.to_s,"color:red|40.6398,-73.7789")
     assert_equal(@marker.to_s_rnd,"color:red|40.64,-73.779")
     
     @marker2 = MapMarker.new(@jfk,"J")
     assert_not_nil(@marker2)
     assert_equal(@marker2.to_s,"color:white|label:J|40.6398,-73.7789")
     
   end
end
