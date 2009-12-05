require File.dirname(__FILE__) + '/../test_helper'

class DurationTest < ActiveSupport::TestCase

  def test_duration
    a = Duration.new(15,:seconds)
    assert a.in_seconds == 15

    b = Duration.new_using_seconds(15)
    assert b.in_seconds == 15    
    assert b.in_minutes == 0.25
    
    c = Duration.new(15,:minutes)
    assert c.in_seconds == 15*60

    d = Duration.new_using_minutes(15)
    assert d.in_seconds == 15*60
    assert d.in_hours == 0.25
        
    e = Duration.new(15,:hours)
    assert e.in_seconds == 15*3600

    f = Duration.new_using_hours(15)
    assert f.in_minutes == 15*60
       
    assert_raise(ArgumentError){Duration.new(15,:bob)}
  end
end
