require File.dirname(__FILE__) + '/../../test_helper'

class AirlineTest < ActiveSupport::TestCase
  
  def test_associations_with_plane_class
    load_instance_vars
    
    my_airlines_planes = @airline_3.planes
    assert_kind_of(Array,my_airlines_planes) 
    assert my_airlines_planes.include?(@plane_2)
    assert @plane_2.airline == @airline_3
  end
  
  def test_associations_with_airport_class
    load_instance_vars
    
    my_airports = Airport.ops_airline_is(@airline_1)
    assert_kind_of(Array,my_airports) 
    assert my_airports.include?(@lax)
    assert my_airports.include?(@iad)
    assert my_airports == @airline_1.ops_airports
    assert @airline_3.home_airport_game == @iad
    
  end
  
  def test_acquire_new_plane
    load_instance_vars
    
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
    
    my_flights = @airline_3.flights
    assert my_flights.include?(@flight_221)
    assert my_flights.include?(@flight_222)
  end
  
  def test_acquire_new_terminal
    load_instance_vars
    
    assert_equal(300.50,@account_1.balance) 
    assert_equal(false,@airline_1.ops_airports.include?(@cdg))
    @airline_1.acquire_new_terminal(@cdg)
    
    load_instance_vars
    assert_equal(180.50,@account_1.balance) 
    assert_equal(true,@airline_1.ops_airports.include?(@cdg))
  end
  
  def test_satisfaction_rating_increase
    load_instance_vars
    assert_equal(9,@airline_1.satisfaction_rating)
    result = @airline_1.satisfaction_rating_increase(0.5)    
    assert_equal(true,result)
    assert_equal(9.5,@airline_1.satisfaction_rating)
  end
  
  def test_satisfaction_rating_decrease
    load_instance_vars
    assert_equal(9,@airline_1.satisfaction_rating)
    result = @airline_1.satisfaction_rating_decrease(2.25)    
    assert_equal(true,result)
    assert_equal(6.75,@airline_1.satisfaction_rating)
    result = @airline_1.satisfaction_rating_decrease(7)    
    assert_equal(false,result)
    assert_equal(6.75,@airline_1.satisfaction_rating)
  end
  
  def test_record_transaction
    @new_airline = Airline.new
    assert_equal(false,@new_airline.record_transaction)
  end
  
end
