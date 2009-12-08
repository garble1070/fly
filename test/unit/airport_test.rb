require File.dirname(__FILE__) + '/../test_helper'

class AirportTest < ActiveSupport::TestCase
  
  def test_link_to_route_class
    @route = Route.find(1)
    assert_not_nil(@route)
    
    @dep_airport_lax = @route.dep_airport
    assert_not_nil(@dep_airport_lax)
    
    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    assert @dep_airport_lax == @lax
    
    @arr_airport_zrh = @route.arr_airport
    assert_not_nil(@arr_airport_zrh)
    
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    assert @arr_airport_zrh == @zrh
end

def test_link_from_route_class
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    
    routes_with_dep_city_zrh = @zrh.routes_by_dep_city
    assert_kind_of(Array,routes_with_dep_city_zrh) 
    
    @dep_city_zrh_route = Route.find(4)
    assert_not_nil(@dep_city_zrh_route)
    assert routes_with_dep_city_zrh.include?(@dep_city_zrh_route)

    @iad = Airport.find("IAD")
    assert_not_nil(@iad)
    
    routes_with_arr_city_iad = @iad.routes_by_arr_city
    assert_kind_of(Array,routes_with_arr_city_iad) 
    
    @arr_city_iad_route = Route.find(5)
    assert_not_nil(@arr_city_iad_route)
    assert routes_with_arr_city_iad.include?(@arr_city_iad_route)
    
    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    
    routes_with_lax = @lax.routes_all
    assert_kind_of(Array,routes_with_lax)
    
    @dep_city_lax_route = Route.find(1)
    assert_not_nil(@dep_city_lax_route)
    assert routes_with_lax.include?(@dep_city_lax_route)
    
    @arr_city_lax_route = Route.find(2)
    assert_not_nil(@arr_city_lax_route)
    assert routes_with_lax.include?(@arr_city_lax_route)
  end
  
  def test_link_to_plane_class
    @plane = Plane.find(1)
    assert_not_nil(@plane)
    
    @starting_airport_zrh = @plane.starting_airport
    assert_not_nil(@starting_airport_zrh)
    
    @starting_airport_zrh_obj = @plane.starting_airport_obj
    assert_not_nil(@starting_airport_zrh_obj)
    
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    assert @starting_airport_zrh == @zrh
    assert @starting_airport_zrh_obj == @zrh
  end
  
end


