require File.dirname(__FILE__) + '/../../test_helper'

class FlightMapTest < ActiveSupport::TestCase
  
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
    
    generated_url_preflight = @flight_map.complete_url
    part1 = "?maptype=terrain&format=jpg&sensor=false&size=450x300"
    part2 = "&key=ABQIAAAAHjDfn4JyllVUPtyJ31qLhhSjmO-kHhwqX2l12pfya7ICKXzFqhRq3QRp0Ql03P59GaKmwMasDuskrA"
    part3 = "&markers=color:red|label:D|33.943,-118.408&markers=color:green|label:A|37.619,-122.375"
    part4 = "&path=color:0x555555AA|weight:5|33.943,-118.408|35.797,-120.346|37.619,-122.375"
    expected_url_preflight = part1 + part2 + part3 + part4
    assert_equal(generated_url_preflight,expected_url_preflight)
    
    generated_url_inflight = @flight_map.complete_url(200)
    part5 = "&markers=color:yellow|36.134,-120.711"
    part6 = "&path=color:0xFFFF00FF|weight:6|33.943,-118.408|35.044,-119.544|36.134,-120.711"
    expected_url_inflight = expected_url_preflight + part5 + part6  
    assert_equal(generated_url_inflight, expected_url_inflight)
    
    generated_url_too_long = @flight_map.complete_url(1000)
    part5 = "&markers=color:yellow|37.619,-122.375"
    part6 = "&path=color:0xFFFF00FF|weight:6|33.943,-118.408|35.797,-120.346|37.619,-122.375"
    expected_url_too_long = expected_url_preflight + part5 + part6  
    assert_equal(generated_url_too_long, expected_url_too_long)

  end
end
