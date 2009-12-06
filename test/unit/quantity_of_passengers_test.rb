require File.dirname(__FILE__) + '/../test_helper'

class QuantityOfPassengersTest < ActiveSupport::TestCase

  def test_quantity
    a = QuantityOfPassengers.new(15)
    assert_not_nil(a)
    assert a.type == "passengers"
    assert a.quantity == 15
    
    a.increase(20)
    assert a.quantity == 35
    
    b = a + 30
    assert_not_nil(b)
    assert b.type == "passengers"
    assert b.quantity == 65 
    
    c = a + b
    assert_not_nil(c)
    assert c.quantity == 100

    c.decrease(10)    
    assert c.quantity == 90
    
    d = c - b
    assert d.quantity == 25
  end
end
