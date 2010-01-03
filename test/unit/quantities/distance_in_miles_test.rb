require File.dirname(__FILE__) + '/../../test_helper'

class DistanceInMilesTest < ActiveSupport::TestCase
  
  def test_basics
    d = DistanceInMiles.new
    d.in_miles = 30
    assert_equal(d.in_nautical_miles,30 / NAUTICAL_MILE_IN_MILES)
    
    d.in_nautical_miles = 30
    assert_equal(d.in_miles,30 * NAUTICAL_MILE_IN_MILES)
    
  end
  
end
