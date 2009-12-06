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
  
=begin
  def test_create_new_plane_better
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @lax = Airport.get("LAX")
    assert_not_nil(@lax)

    @plane_creator = PlaneCreator.new
    @plane_creator << @airline
    @plane_creator << @a330
    @plane_creator << @lax

  end
=end
  
  def test_create_new_plane
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @lax = Airport.get("LAX")
    assert_not_nil(@lax)
    
    @my_plane = @airline.acquire_plane(@a330,@lax,
             {:starting_pax_count => 60000, :starting_miles_count => 100000})
    assert_not_nil(@my_plane)
    
    assert_kind_of(Fixnum,@my_plane.id)
    assert @my_plane.id > 0
    assert @my_plane.starting_pax_count == 60000
    assert @my_plane.starting_miles_count == 100000
    
    assert @a330.avg_pax_load_default == @my_plane.avg_pax_load
    assert @a330.avg_speed_default == @my_plane.avg_speed
    assert @a330.range_default == @my_plane.range
    
    @my_plane2 = @airline.acquire_plane(@a330,@lax)
    assert_not_nil(@my_plane2)

    assert @my_plane2.starting_pax_count == 0
    assert @my_plane2.starting_miles_count == 0
    
    assert_raise(ArgumentError){@airline.acquire_plane(@lax,@lax)}
    assert_raise(ArgumentError){@airline.acquire_plane(@a330,@a330)}
    assert_raise(ArgumentError){@airline.acquire_plane(@a330,@lax,4)}
    assert_raise(RuntimeError){@airline.acquire_plane(Aircrafttype.new,@lax)}
    assert_raise(RuntimeError){@airline.acquire_plane(@a330,Airport.new)}
    assert_raise(RuntimeError){Airline.new.acquire_plane(@a330,@lax)}
    
    
  end
  
end
