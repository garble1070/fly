require File.dirname(__FILE__) + '/../test_helper'

class DurationInSecondsTest < ActiveSupport::TestCase

  def test_duration_in_seconds
    
    a = DurationInSeconds.new(15)
    assert_not_nil(a)
    assert a.duration_in_seconds == 15
    
    a.increase(20)
    assert a.duration_in_seconds == 35
    
    b = a + 30
    assert_not_nil(b)
    assert b.duration_in_seconds == 65 
    
    c = a + b
    assert_not_nil(c)
    assert c.duration_in_seconds == 100

    c.decrease(10)    
    assert c.duration_in_seconds == 90
    
    d = c - b
    assert_not_nil(d)
    assert d.duration_in_seconds == 25

    e = DurationInSeconds.new(3600)
    assert_not_nil(e)
    assert e.duration_in_seconds == 3600
    assert e.duration_in_minutes == 60
    assert e.duration_in_hours == 1
        
  end
end
