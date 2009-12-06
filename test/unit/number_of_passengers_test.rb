require File.dirname(__FILE__) + '/../test_helper'

class NumberOfPassengersTest < ActiveSupport::TestCase

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
end
