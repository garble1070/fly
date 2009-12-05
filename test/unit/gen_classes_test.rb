require File.dirname(__FILE__) + '/../test_helper'

class GenClassesTest < ActiveSupport::TestCase

  def test_duration
    a = Duration.new(15)
    b = Duration.new(15,:secs)
    c = Duration.new(15,:seconds)
    d = Seconds.new(15)
    
    assert a.in_seconds == 15
    assert b.in_seconds == 15
    assert c.in_seconds == 15
    assert d.in_seconds == 15
    assert d.in_minutes == 0.25
    
    e = Duration.new(15,:minutes)
    f = Duration.new(15,:mins)
    g = Minutes.new(15)
    
    assert e.in_seconds == 15*60
    assert f.in_seconds == 15*60
    assert g.in_seconds == 15*60
    assert g.in_hours == 0.25
    
    h = Duration.new(15,:hours)
    i = Duration.new(15,:hrs)
    j = Hours.new(15)
    
    assert h.in_seconds == 15*3600
    assert i.in_seconds == 15*3600
    assert j.in_seconds == 15*3600
    
    assert_raise(ArgumentError){Duration.new(15,:bob)}
  end
end
