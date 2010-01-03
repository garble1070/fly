require File.dirname(__FILE__) + '/../../test_helper'

class DurationInSecondsTest < ActiveSupport::TestCase
  
  def test_basics
    
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
