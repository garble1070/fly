require File.dirname(__FILE__) + '/../../test_helper'

class DurationInSecondsTest < ActiveSupport::TestCase
  
  def test_basics
    
    a = DurationInSeconds.new(15)
    assert_equal(a.in_seconds,15)
    
    a.increase(20)
    assert_equal(a.in_seconds,35)
    
    b = a + 30
    assert_equal(b.in_seconds,65)
    
    c = a + b
    assert_equal(c.in_seconds,100)
    
    c.decrease(10)    
    assert_equal(c.in_seconds,90)
    
    d = c - b
    assert_equal(d.in_seconds,25)
    
    e = DurationInSeconds.new(3600)
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
  
end
