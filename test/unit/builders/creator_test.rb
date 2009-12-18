require File.dirname(__FILE__) + '/../../test_helper'

class CreatorTest < ActiveSupport::TestCase
  
  def test_basics
    @creator = Creator.new
    assert_raise(RuntimeError) {@creator.generate_new_item_object}
    assert_raise(RuntimeError) {@creator.insert_required_params_into_new_item_object}
    assert_raise(RuntimeError) {@creator.insert_optional_params_into_new_item_object}
  end
end
  