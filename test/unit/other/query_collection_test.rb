require File.dirname(__FILE__) + '/../../test_helper'

class QueryCollectionTest < ActiveSupport::TestCase
  
  def test_non_exclusive_key_methods
    @query = QueryCollectionNonExclusiveKey.new
    assert_not_nil(@query)
    @query.add_param("keyname","valuevalue")
    assert_equal(@query.keyname,["valuevalue"])
    
    @querytwo = @query.copy_and_add_param("bob","valuevalue")
    assert_equal(@querytwo.bob,["valuevalue"])
    
    @param_array = @query.find("keyname")
    assert_not_nil(@param_array)
    @param = @param_array[0]
    assert_not_nil(@param)
    assert_equal(@param.value,"valuevalue")
    
    @querytwo = @query.copy
    assert_not_nil(@querytwo)
    assert_equal(@querytwo.keyname,["valuevalue"])
    assert @query.object_id != @querytwo.object_id
    
    @query.add_param("keyname","anothervalue")
    @query.add_param("nextkey","nextvalue")
    @output = @query.output
    assert_equal(@output,"?keyname=valuevalue&keyname=anothervalue&nextkey=nextvalue")
  end
  
  def test_exclusive_key_methods
    @query = QueryCollectionExclusiveKey.new
    assert_not_nil(@query)
    @query.add_param("keyname","valuevalue")
    assert_equal(@query.keyname,"valuevalue")
    
    @query.add_param("keyname","nextvalue")
    assert_equal(@query.keyname,"nextvalue")

    @querytwo = @query.copy_and_add_param("keyname","anothervalue")
    assert_equal(@querytwo.keyname,"anothervalue")
    
    @param = @query.find("keyname")
    assert_not_nil(@param)
    assert_equal(@param.value,"nextvalue")
    
    @querytwo.delete_param("keyname")
    assert_equal(@querytwo.find("keyname"),nil)    
    
    @querythree = @query.copy
    assert_not_nil(@querythree)
    assert_equal(@querythree.keyname,"nextvalue")
    assert @query.object_id != @querythree.object_id
    
    @queryfour = @query.copy_and_delete_param("keyname")
    assert_equal(@queryfour.find("keyname"),nil)    
    
    @togglequery = QueryCollectionExclusiveKey.new
    @togglequery.add_param("keyname",1,:binary)
    @togglequery.toggle_param("keyname")
    assert_equal(@togglequery.keyname,nil)
    @togglequery.toggle_param("keyname")
    assert_equal(@togglequery.keyname.to_s,"1")

    @togglequery.add_param("keyname",0,:zero)
    @togglequery.toggle_param("keyname")
    assert_equal(@togglequery.keyname,nil)
    @togglequery.toggle_param("keyname")
    assert_equal(@togglequery.keyname.to_s,"0")
    
    assert_equal(@query.nonamekey,nil)
    assert_equal(@querythree.toggle_param("keyname"),nil)
    
    @query.add_param("keyname","yetanothervalue")
    @query.add_param("nextkey","nextvalue")
    assert_equal(@query.output,"?keyname=yetanothervalue&nextkey=nextvalue")
    @query.add_param("hashkey",{:keyone => "valone"})
    assert_equal(@query.output,"?keyname=yetanothervalue&nextkey=nextvalue")
    
  end
  
  def test_superclass_methods
    @query = QueryCollection.new
    assert_raise(RuntimeError) {@query.find("bob")}
    assert_raise(RuntimeError) {@query.add_param("bob","smith")}
    
  end
  
end
