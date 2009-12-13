require File.dirname(__FILE__) + '/../../test_helper'

class QueryCollectionTest < ActiveSupport::TestCase
  
  def test_add_param_methods
    @query = QueryCollectionNonExclusiveKey.new
    assert_not_nil(@query)
    @query.add_param("keyname","valuevalue")
    assert @query.keyname == ["valuevalue"]

    @querytwo = @query.copy
    assert_not_nil(@querytwo)
    assert @querytwo.keyname == ["valuevalue"]
    assert @query.object_id != @querytwo.object_id
  end
  
  def test_find_methods
    
  end
  
  def test_delete_param_methods
    
  end
  
  def test_output
    
  end
  
end
