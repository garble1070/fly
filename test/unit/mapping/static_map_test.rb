require File.dirname(__FILE__) + '/../../test_helper'

class StaticMapTest < ActiveSupport::TestCase
  
  def test_basics
    @static_map = StaticMap.new
    assert_raise(RuntimeError) {@static_map.insert_basic_params_for_map_subclass}

  end
end
