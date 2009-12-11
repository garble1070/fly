require File.dirname(__FILE__) + '/../test_helper'

class AirportTest < ActiveSupport::TestCase  
  
  def test_geokit_basics
    @sfo = Airport.find("SFO")
    assert_not_nil(@sfo)
 
    @iad = Airport.find("IAD")
    assert_not_nil(@iad)
    
    distance_in_miles = @sfo.distance_from(@iad).to_int
    assert distance_in_miles == 2415
    
    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    assert @lax.geo_coords == [33.9425, -118.408]
    
  end
  
  def test_link_to_plane_class
    @plane = Plane.find(1)
    assert_not_nil(@plane)
    
    @starting_airport_zrh = @plane.starting_airport
    assert_not_nil(@starting_airport_zrh)
    
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    assert @starting_airport_zrh == @zrh
  end
  
  def test_link_to_user_class

    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    assert @lax.users_based_here_in_real_life == [User.find(15)]
  end
  
  def test_associations_with_airline_class
    @swissair = Airline.find(1)
    assert_not_nil(@swissair)
    
    @lufthansa = Airline.find(2)
    assert_not_nil(@lufthansa)

    @lax = Airport.find("LAX")
    assert_not_nil(@lax)

    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)

    assert @zrh.airlines_based_here_in_game.include?(@swissair)

    my_airlines = Airline.ops_airport_is(@lax)
    assert_kind_of(Array,my_airlines) 
    assert my_airlines.include?(@swissair)
    assert my_airlines.include?(@lufthansa)
    
    assert my_airlines == @lax.ops_airlines
  end
 
end
