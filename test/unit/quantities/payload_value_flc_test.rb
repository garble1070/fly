require File.dirname(__FILE__) + '/../../test_helper'

class PayloadValueFlcTest < ActiveSupport::TestCase
  
  def test_basics
    @payload_value_flc = PayloadValueFlc.new
    @payload_value_flc.payload_value_flc = 20
    assert_equal(20,@payload_value_flc.payload_value_flc)
  end
  
  def test_set_payload_value_by_distance_and_pax_count
    @payload_value_flc = PayloadValueFlc.new
    @payload_value_flc.set_payload_value_by_distance_and_pax_count(1200,150)
    assert_equal(16.1,@payload_value_flc.payload_value_flc)
  end
end
