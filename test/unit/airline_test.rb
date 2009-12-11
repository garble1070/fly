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
    
    assert @plane.airline == @airline
  end
  
  def test_associations_with_airport_class
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @lax = Airport.find("lax")
    assert_not_nil(@lax)
    
    @iad = Airport.find("iad")
    assert_not_nil(@iad)
    
    @dfw = Airport.find("dfw")
    assert_not_nil(@dfw)
    
    my_airports = Airport.ops_airline_is(@airline)
    assert_kind_of(Array,my_airports) 
    assert my_airports.include?(@lax)
    assert my_airports.include?(@iad)
    assert my_airports.include?(@dfw)
    
    assert my_airports == @airline.ops_airports

    @airline2 = Airline.find(3)
    assert_not_nil(@airline2)
    
    assert @airline2.home_airport_game == @iad

  end
  
  def test_acquire_new_plane
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    
    config_params = [@airline,@a330,@lax]
    @finished_plane = @airline.acquire_new_plane(config_params)
    assert_not_nil(@finished_plane)
    assert_kind_of(Plane,@finished_plane)
    
    assert_kind_of(Fixnum,@finished_plane.id)
    assert @finished_plane.id > 0
    
  end
  
  def test_associations_with_flights
    @oak_to_mia = Flight.find(221)
    assert_not_nil(@oak_to_mia)
    
    @mia_to_zrh = Flight.find(222)
    assert_not_nil(@mia_to_zrh)
    
    @airline = Airline.find(3)
    assert_not_nil(@airline)
    
    my_flights = @airline.flights
    assert my_flights.include?(@oak_to_mia)
    assert my_flights.include?(@mia_to_zrh)
  end
  
end
