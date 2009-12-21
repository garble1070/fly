require File.dirname(__FILE__) + '/../../test_helper'

class AirlineTest < ActiveSupport::TestCase
  
  def load_instance_vars
    @airline_1 = Airline.find(1)
    @airline_3 = Airline.find(3)
    @flight_221 = Flight.find(221)
    @flight_222 = Flight.find(222)
    @plane_2 = Plane.find(2)
    @lax = Airport.find("LAX")    
    @sfo = Airport.find("SFO")
    @iad = Airport.find("IAD")
    @dfw = Airport.find("dfw")
    @jfk = Airport.find("jfk")
    @a330 = Aircrafttype.find(1)
    @account_1 = Account.find(1)
  end
  
  def test_associations_with_plane_class
    load_instance_vars
    assert_not_nil(@airline_3)
    assert_not_nil(@plane_2)
    
    my_airlines_planes = @airline_3.planes
    assert_kind_of(Array,my_airlines_planes) 
    assert my_airlines_planes.include?(@plane_2)
    assert @plane_2.airline == @airline_3
  end
  
  def test_associations_with_airport_class
    load_instance_vars
    assert_not_nil(@airline_1)
    assert_not_nil(@airline_3)
    assert_not_nil(@lax)
    assert_not_nil(@iad)
    
    my_airports = Airport.ops_airline_is(@airline_1)
    assert_kind_of(Array,my_airports) 
    assert my_airports.include?(@lax)
    assert my_airports.include?(@iad)
    assert my_airports == @airline_1.ops_airports
    assert @airline_3.home_airport_game == @iad
    
  end
  
  def test_acquire_new_plane
    load_instance_vars
    assert_not_nil(@a330)
    assert_not_nil(@account_1)

    assert_equal(@account_1.balance,300.50)
    @finished_plane = @airline_1.acquire_new_plane(@a330)
    assert_not_nil(@finished_plane)
    assert_kind_of(Plane,@finished_plane)
    assert_kind_of(Fixnum,@finished_plane.id)
    assert @finished_plane.id > 0
    
    load_instance_vars
    assert_equal(@account_1.balance,150.50)
    @finished_plane2 = @airline_1.acquire_new_plane(@a330)
    assert_kind_of(Plane,@finished_plane2)
    
    load_instance_vars
    assert_equal(@account_1.balance,0.50)
    @attempted_plane = @airline_1.acquire_new_plane(@a330)
    assert_equal(@attempted_plane,nil)
    
  end
  
  def test_associations_with_flights
    load_instance_vars
    assert_not_nil(@airline_3)
    assert_not_nil(@flight_221)
    assert_not_nil(@flight_222)
    
    my_flights = @airline_3.flights
    assert my_flights.include?(@flight_221)
    assert my_flights.include?(@flight_222)
  end
  
end
