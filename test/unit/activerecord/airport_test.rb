require File.dirname(__FILE__) + '/../../test_helper'

class AirportTest < ActiveSupport::TestCase  
  
  def test_geokit_basics
    @sfo = Airport.find("SFO")
    assert_not_nil(@sfo)
    
    @iad = Airport.find("IAD")
    assert_not_nil(@iad)

    @lax = Airport.find("LAX")
    assert_not_nil(@lax)

    distance_in_miles = @sfo.distance_from(@iad).to_int
    assert distance_in_miles,2415
    assert_equal(@lax.to_s,"33.9425,-118.408")
    
  end
  
  def test_link_to_plane_class
    @plane = Plane.find(1)
    assert_not_nil(@plane)
    
    @starting_airport_zrh = @plane.starting_airport
    assert_not_nil(@starting_airport_zrh)
    
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    assert_equal(@starting_airport_zrh,@zrh)
  end
  
  def test_link_to_user_class
    
    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    assert_equal(@lax.users_based_here_in_real_life,[User.find(15)])
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
    
    assert_equal(my_airlines,@lax.ops_airlines)
  end
  
  def test_geocodes
    @jfk = Airport.find("jfk")
    assert_equal(@jfk.to_s,"40.6398,-73.7789")
    assert_equal(@jfk.to_s_rnd,"40.64,-73.779")
  end
  
  def test_method_missing_class_method
    @lax = Airport.lax
    assert_equal(@lax,Airport.find("lax"))
  end
  
end
