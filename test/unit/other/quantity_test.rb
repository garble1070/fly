require File.dirname(__FILE__) + '/../../test_helper'

class QuantityTest < ActiveSupport::TestCase

  def test_duration_in_seconds
    
    a = DurationInSeconds.new(15)
    assert_not_nil(a)
    assert a.in_seconds == 15
    
    a.increase(20)
    assert a.in_seconds == 35
    
    b = a + 30
    assert_not_nil(b)
    assert b.in_seconds == 65 
    
    c = a + b
    assert_not_nil(c)
    assert c.in_seconds == 100

    c.decrease(10)    
    assert c.in_seconds == 90
    
    d = c - b
    assert_not_nil(d)
    assert d.in_seconds == 25

    e = DurationInSeconds.new(3600)
    assert_not_nil(e)
    assert e.in_seconds == 3600
    assert e.in_minutes == 60
    assert e.in_hours == 1
        
  end
  
  def test_number_of_passengers
    a = NumberOfPassengers.new(15)
    assert_not_nil(a)
    assert a.number_of_passengers == 15
    
    a.increase(20)
    assert a.number_of_passengers == 35
    
    b = a + 30
    assert_not_nil(b)
    assert b.number_of_passengers == 65 
    
    c = a + b
    assert_not_nil(c)
    assert c.number_of_passengers == 100

    c.decrease(10)    
    assert c.number_of_passengers == 90
    
    d = c - b
    assert_not_nil(d)
    assert d.number_of_passengers == 25
  end
  
    def test_distance_in_miles
    a = DistanceInMiles.new(15)
    assert_not_nil(a)
    assert a.in_miles == 15
    
    a.increase(20)
    assert a.in_miles == 35
    
    b = a + 30
    assert_not_nil(b)
    assert b.in_miles == 65 
    
    c = a + b
    assert_not_nil(c)
    assert c.in_miles == 100

    c.decrease(10)    
    assert c.in_miles == 90
    
    d = c - b
    assert_not_nil(d)
    assert d.in_miles == 25
  end
end
