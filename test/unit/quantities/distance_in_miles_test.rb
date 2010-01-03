require File.dirname(__FILE__) + '/../../test_helper'

class DistanceInMilesTest < ActiveSupport::TestCase
  
  def test_basics
    a = DistanceInMiles.new(15)
    assert_equal(a.in_miles,15)
    
    a.increase(20)
    assert_equal(a.in_miles,35)
    
    b = a + 30
    assert_equal(b.in_miles,65)
    
    c = a + b
    assert_equal(c.in_miles,100)
    
    c.decrease(10)    
    assert_equal(c.in_miles,90)
    
    d = c - b
    assert_equal(d.in_miles,25)
    
    d.in_miles = 30
    assert_equal(d.in_nautical_miles,30 / NAUTICAL_MILE_IN_MILES)
    
    d.in_nautical_miles = 30
    assert_equal(d.in_miles,30 * NAUTICAL_MILE_IN_MILES)
    
  end
  
end
