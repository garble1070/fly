require File.dirname(__FILE__) + '/../test_helper'

class AirlineTest < ActiveSupport::TestCase
  
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

    assert_raise(ArgumentError){@airline.acquire_plane(@lax,@lax)}
    assert_raise(ArgumentError){@airline.acquire_plane(@a330,@a330)}
    assert_raise(ArgumentError){@airline.acquire_plane(@a330,@lax,4)}
    assert_raise(RuntimeError){@airline.acquire_plane(Aircrafttype.new,@lax)}
    assert_raise(RuntimeError){@airline.acquire_plane(@a330,Airport.new)}
    assert_raise(RuntimeError){Airline.new.acquire_plane(@a330,@lax)}

  
  end

end
