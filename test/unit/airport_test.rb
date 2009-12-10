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
    assert @lax.users_based_here_in_game == [User.find(16)]
  end
  
end
