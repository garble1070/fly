require File.dirname(__FILE__) + '/../../test_helper'

class StartingPaxCountTest < ActiveSupport::TestCase
  
  def test_basics
    @pax = StartingPaxCount.new(60000)
    @pax.starting_pax_count = 50000
    assert_equal(50000,@pax.starting_pax_count)
  end
  
end
