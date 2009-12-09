require File.dirname(__FILE__) + '/../test_helper'

class AircrafttypeTest < ActiveSupport::TestCase
  
  def test_associations_with_plane_class
    @aircrafttype = Aircrafttype.find(1)
    assert_not_nil(@aircrafttype)

    @plane = Plane.find(1)
    assert_not_nil(@plane)

    my_aircrafttypes_planes = @aircrafttype.planes
    assert_kind_of(Array,my_aircrafttypes_planes) 
    assert my_aircrafttypes_planes.include?(@plane)
    
    assert @plane.aircrafttype == @aircrafttype
  end
  
end
