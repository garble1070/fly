require File.dirname(__FILE__) + '/../../test_helper'

class FlightMilesTest < ActiveSupport::TestCase
  
  def test_basics
    a = FlightMiles.new    
    a.flight_miles = 40
    assert_equal(a.flight_miles,40)
  end
    
end
