require File.dirname(__FILE__) + '/../../test_helper'

class PaxCountTest < ActiveSupport::TestCase
  
  def test_basics
    a = PaxCount.new(15)
    assert_equal(a.pax_count,15)
    
    a.increase(20)
    assert_equal(a.pax_count,35)
    
    b = a + 30
    assert_equal(b.pax_count,65)
    
    c = a + b
    assert_equal(c.pax_count,100)
    
    c.decrease(10)    
    assert_equal(c.pax_count,90)
    
    d = c - b
    assert_equal(d.pax_count,25)
    
    d.pax_count = 40
    assert_equal(d.pax_count,40)
  end
    
end
