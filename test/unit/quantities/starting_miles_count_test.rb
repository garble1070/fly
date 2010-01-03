require File.dirname(__FILE__) + '/../../test_helper'

class StartingMilesCountTest < ActiveSupport::TestCase
  
  def test_basics
    @miles = StartingMilesCount.new(100000)
    @miles.starting_miles_count = 75000
    assert_equal(75000,@miles.starting_miles_count)
  end
  
end
