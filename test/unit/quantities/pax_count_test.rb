require File.dirname(__FILE__) + '/../../test_helper'

class PaxCountTest < ActiveSupport::TestCase
  
  def test_basics
    d = PaxCount.new
    d.pax_count = 40
    assert_equal(d.pax_count,40)
  end
    
end
