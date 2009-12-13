require File.dirname(__FILE__) + '/../../test_helper'

class QueryCollectionTest < ActiveSupport::TestCase
  
  def test_non_exclusive_key_methods
    @query = QueryCollectionNonExclusiveKey.new
    assert_not_nil(@query)
    @query.add_param("keyname","valuevalue")
    assert @query.keyname == ["valuevalue"]

    @param_array = @query.find("keyname")
    assert_not_nil(@param_array)
    @param = @param_array[0]
    assert_not_nil(@param)
    assert @param.value == "valuevalue"

    @querytwo = @query.copy
    assert_not_nil(@querytwo)
    assert @querytwo.keyname == ["valuevalue"]
    assert @query.object_id != @querytwo.object_id
    
    @query.add_param("keyname","anothervalue")
    @query.add_param("nextkey","nextvalue")
    @output = @query.output
    assert @output == "?keyname=valuevalue&keyname=anothervalue&nextkey=nextvalue"
    
end
  
  
end
