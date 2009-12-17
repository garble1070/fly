require File.dirname(__FILE__) + '/../../test_helper'

class QuantityTest < ActiveSupport::TestCase
  
  def test_duration_in_seconds
    
    a = DurationInSeconds.new(15)
    assert_not_nil(a)
    assert_equal(a.in_seconds,15)
    
    a.increase(20)
    assert_equal(a.in_seconds,35)
    
    b = a + 30
    assert_not_nil(b)
    assert_equal(b.in_seconds,65)
    
    c = a + b
    assert_not_nil(c)
    assert_equal(c.in_seconds,100)
    
    c.decrease(10)    
    assert_equal(c.in_seconds,90)
    
    d = c - b
    assert_not_nil(d)
    assert_equal(d.in_seconds,25)
    
    e = DurationInSeconds.new(3600)
    assert_not_nil(e)
    assert_equal(e.in_seconds,3600)
    assert_equal(e.in_minutes,60)
    assert_equal(e.in_hours,1)
    
    f = DurationInSeconds.new_in_minutes(1)
    assert_equal(f.in_seconds,60)
    f = DurationInSeconds.new_in_hours(1)
    assert_equal(f.in_seconds,3600)
    
    f.in_seconds = 120
    assert_equal(f.in_seconds,120)
    
    
  end
  
  def test_number_of_passengers
    a = NumberOfPassengers.new(15)
    assert_not_nil(a)
    assert_equal(a.number_of_passengers,15)
    
    a.increase(20)
    assert_equal(a.number_of_passengers,35)
    
    b = a + 30
    assert_not_nil(b)
    assert_equal(b.number_of_passengers,65)
    
    c = a + b
    assert_not_nil(c)
    assert_equal(c.number_of_passengers,100)
    
    c.decrease(10)    
    assert_equal(c.number_of_passengers,90)
    
    d = c - b
    assert_not_nil(d)
    assert_equal(d.number_of_passengers,25)
    
    d.number_of_passengers = 40
    assert_equal(d.number_of_passengers,40)
  end
  
  def test_distance_in_miles
    a = DistanceInMiles.new(15)
    assert_not_nil(a)
    assert_equal(a.in_miles,15)
    
    a.increase(20)
    assert_equal(a.in_miles,35)
    
    b = a + 30
    assert_not_nil(b)
    assert_equal(b.in_miles,65)
    
    c = a + b
    assert_not_nil(c)
    assert_equal(c.in_miles,100)
    
    c.decrease(10)    
    assert_equal(c.in_miles,90)
    
    d = c - b
    assert_not_nil(d)
    assert_equal(d.in_miles,25)
    
    d.in_miles = 30
    assert_equal(d.in_nautical_miles,30 / NAUTICAL_MILE_IN_MILES)
    
    d.in_nautical_miles = 30
    assert_equal(d.in_miles,30 * NAUTICAL_MILE_IN_MILES)
    
  end
  
  def test_starting_pax_and_miles
    @sixty_thousand_pax = StartingPaxCount.new(60000)
    @one_hundred_k_miles = StartingMilesCount.new(100000)
    @sixty_thousand_pax.starting_pax_count = 50000
    assert @sixty_thousand_pax.starting_pax_count == 50000
    @one_hundred_k_miles.starting_miles_count = 75000
    assert @one_hundred_k_miles.starting_miles_count == 75000
    
  end
end
