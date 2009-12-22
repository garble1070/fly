require File.dirname(__FILE__) + '/../../test_helper'

class AircrafttypeTest < ActiveSupport::TestCase
  
  def test_associations_with_plane_class
    load_instance_vars

    my_aircrafttypes_planes = @a330.planes
    assert_kind_of(Array,my_aircrafttypes_planes) 
    assert_equal(true,my_aircrafttypes_planes.include?(@plane_1))
    assert_equal(@a330,@plane_1.aircrafttype)
  end
  
end
