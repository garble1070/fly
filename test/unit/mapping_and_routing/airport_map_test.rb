require File.dirname(__FILE__) + '/../../test_helper'

class AirportMapTest < ActiveSupport::TestCase
  
  def test_basics
    @my_airline = Airline.find(1)
    assert_not_nil(@my_airline)
    
    @a_map = AirportMap.new(@my_airline)
    assert_not_nil(@a_map)
    
    
  end
end
