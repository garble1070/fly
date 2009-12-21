require File.dirname(__FILE__) + '/../../test_helper'

class AirportTest < ActiveSupport::TestCase  
  
  def load_instance_vars
    @lax = Airport.find("LAX")    
    @sfo = Airport.find("SFO")
    @iad = Airport.find("IAD")
    @zrh = Airport.find("ZRH")
    @jfk = Airport.find("jfk")
    @plane_1 = Plane.find(1)
    @user_15 = User.find(15)
    @airline_1 = Airline.find(1)
    @airline_2 = Airline.find(2)
  end
  
  def test_geokit_basics
    load_instance_vars
    assert_not_nil(@sfo)
    assert_not_nil(@iad)
    assert_not_nil(@lax)
    
    distance_in_miles = @sfo.distance_from(@iad).to_int
    assert distance_in_miles,2415
    assert_equal(@lax.to_s,"33.9425,-118.408")
    
  end
  
  def test_link_to_plane_class
    load_instance_vars
    assert_not_nil(@plane_1)
    assert_not_nil(@zrh)
    
    @starting_airport_zrh = @plane_1.starting_airport
    assert_equal(@starting_airport_zrh,@zrh)
  end
  
  def test_link_to_user_class
    load_instance_vars  
    assert_not_nil(@lax)
    assert_not_nil(@user_15)

    assert_equal(true,@lax.users_based_here_in_real_life.include?(@user_15))
  end
  
  def test_associations_with_airline_class
    load_instance_vars
    assert_not_nil(@airline_1)
    assert_not_nil(@airline_2)
    assert_not_nil(@lax)
    assert_not_nil(@zrh)
    
    assert @zrh.airlines_based_here_in_game.include?(@airline_1)
    
    my_airlines = Airline.ops_airport_is(@lax)
    assert_kind_of(Array,my_airlines) 
    assert my_airlines.include?(@airline_1)
    assert my_airlines.include?(@airline_2)
    
    assert_equal(my_airlines,@lax.ops_airlines)
  end
  
  def test_geocodes
    load_instance_vars
    assert_not_nil(@jfk)
    
    assert_equal(@jfk.to_s,"40.6398,-73.7789")
    assert_equal(@jfk.to_s_rnd,"40.64,-73.779")
  end
  
  def test_method_missing_class_method
    load_instance_vars
    assert_not_nil(@lax)
    
    assert_equal(@lax,Airport.lax)
  end
  
end
