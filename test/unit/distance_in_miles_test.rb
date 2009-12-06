require File.dirname(__FILE__) + '/../test_helper'

class DistanceInMilesTest < ActiveSupport::TestCase

  def test_distance_in_miles
    a = DistanceInMiles.new(15)
    assert_not_nil(a)
    assert a.distance_in_miles == 15
    
    a.increase(20)
    assert a.distance_in_miles == 35
    
    b = a + 30
    assert_not_nil(b)
    assert b.distance_in_miles == 65 
    
    c = a + b
    assert_not_nil(c)
    assert c.distance_in_miles == 100

    c.decrease(10)    
    assert c.distance_in_miles == 90
    
    d = c - b
    assert_not_nil(d)
    assert d.distance_in_miles == 25
  end
end
