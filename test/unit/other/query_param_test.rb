require File.dirname(__FILE__) + '/../../test_helper'

class QueryParamTest < ActiveSupport::TestCase
 
 def test_constructor
   @qp = QueryParam.new("keyname","valueitem")
   assert_not_nil @qp
   assert @qp.key == "keyname"
   assert @qp.value == "valueitem"
 end
end
