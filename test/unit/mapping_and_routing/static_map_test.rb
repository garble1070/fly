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
  
  def test_next
    @lax = Airport.find("lax")
    @sfo = Airport.find("sfo")   
    @flight_map = FlightMap.new(@lax,@sfo)
    
    complete_url = @flight_map.complete_url
    expected_url_preflight = "?maptype=terrain&format=jpg&sensor=false&size=450x300&key=ABQIAAAAHjDfn4JyllVUPtyJ31qLhhSjmO-kHhwqX2l12pfya7ICKXzFqhRq3QRp0Ql03P59GaKmwMasDuskrA&markers=color:red|label:D|33.943,-118.408&markers=color:green|label:A|37.619,-122.375&path=color:0x555555AA|weight:5|33.943,-118.408|35.797,-120.346|37.619,-122.375"
    assert_equal(complete_url,expected_url_preflight)
    
    complete_url = @flight_map.complete_url(200)
    assert_equal(complete_url,expected_url_preflight + "&markers=color:yellow|36.134,-120.711&path=color:0xFFFF00FF|weight:6|33.943,-118.408|35.044,-119.544|36.134,-120.711")
  end
end
