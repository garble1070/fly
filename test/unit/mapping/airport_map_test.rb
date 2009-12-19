require File.dirname(__FILE__) + '/../../test_helper'

class AirportMapTest < ActiveSupport::TestCase
  
  def test_basics
    @my_airline = Airline.find(1)
    assert_not_nil(@my_airline)
    
    @a_map = AirportMap.new(@my_airline)
    assert_not_nil(@a_map)
    
    expected_url = "?maptype=terrain&format=jpg&sensor=false&size=450x300&key=ABQIAAAAHjDfn4JyllVUPtyJ31qLhhSjmO-kHhwqX2l12pfya7ICKXzFqhRq3QRp0Ql03P59GaKmwMasDuskrA&markers=color:white|32.897,-97.038&markers=color:white|38.945,-77.456&markers=color:white|33.943,-118.408"
    assert_equal(@a_map.complete_url,expected_url)
  end
end
