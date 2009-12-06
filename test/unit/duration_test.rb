require File.dirname(__FILE__) + '/../test_helper'

class DurationInSecondsTest < ActiveSupport::TestCase

  def test_duration
    a = DurationInSeconds.new(15,:seconds)
    assert a.in_seconds == 15

    b = DurationInSeconds.new_using_seconds(15)
    assert b.in_seconds == 15    
    assert b.in_minutes == 0.25
    
    c = DurationInSeconds.new(15,:minutes)
    assert c.in_seconds == 15*60

    d = DurationInSeconds.new_using_minutes(15)
    assert d.in_seconds == 15*60
    assert d.in_hours == 0.25
        
    e = DurationInSeconds.new(15,:hours)
    assert e.in_seconds == 15*3600

    f = DurationInSeconds.new_using_hours(15)
    assert f.in_minutes == 15*60
       
    g = DurationInSeconds.new(15)
    assert g.in_seconds == 15
    
    assert_raise(ArgumentError){DurationInSeconds.new(15,:bob)}
  end
end
