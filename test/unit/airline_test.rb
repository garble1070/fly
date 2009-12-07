require File.dirname(__FILE__) + '/../test_helper'

class AirlineTest < ActiveSupport::TestCase
  
  def test_associations_with_plane_class
    @airline = Airline.find(3)
    assert_not_nil(@airline)

    @plane = Plane.find(2)
    assert_not_nil(@plane)

    my_airlines_planes = @airline.planes
    assert_kind_of(Array,my_airlines_planes) 
    assert my_airlines_planes.include?(@plane)

    assert @plane.airline_obj == @airline
    assert @plane.airline == @airline
  end
  
  def test_acquire_new_plane
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @lax = Airport.get("LAX")
    assert_not_nil(@lax)
    
    config_params = [@airline,@a330,@lax]
    @finished_plane = @airline.acquire_new_plane(config_params)
    assert_not_nil(@finished_plane)
    assert_kind_of(Plane,@finished_plane)
    
    assert_kind_of(Fixnum,@finished_plane.id)
    assert @finished_plane.id > 0

  end
  
end
