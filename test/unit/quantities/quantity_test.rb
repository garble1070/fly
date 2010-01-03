require File.dirname(__FILE__) + '/../../test_helper'

class QuantityTest < ActiveSupport::TestCase
  
  def test_basics
    a = Quantity.new(15)
    assert_equal(a.quantity,15)
    
    a.increase(20)
    assert_equal(a.quantity,35)
    
    b = a + 30
    assert_equal(b.quantity,65)
    
    c = a + b
    assert_equal(c.quantity,100)
    
    c.decrease(10)    
    assert_equal(c.quantity,90)
    
    d = c - b
    assert_equal(d.quantity,25)
  end
  
end
