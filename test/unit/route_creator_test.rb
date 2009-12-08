require File.dirname(__FILE__) + '/../test_helper'

class RouteCreatorTest < ActiveSupport::TestCase
  
  def test_basics
    @lax_dep = DepartureAirport.find("LAX")
    assert_not_nil(@lax_dep)
        
    @zrh_dep = DepartureAirport.find("ZRH")
    assert_not_nil(@zrh_dep)

    @rc = RouteCreator.new
    assert_not_nil(@rc)
    
    @rc.add_param(@zrh_dep)
    assert @rc.param_present?(@zrh_dep) == true
    assert @rc.param_by_classname("DepartureAirport") == @zrh_dep    
    @rc << @lax_dep
    assert @rc.param_present?(@lax_dep) == true
    assert @rc.param_by_classname("DepartureAirport") == @lax_dep    
    @rc.delete_param(@zrh_dep)
    assert_nil(@rc.param_by_classname("DepartureAirport"))

    config_params = [@a330,@zrh_dep]
    @rc = RouteCreator.new(config_params)
    assert_not_nil(@rc)
    assert @rc.required_param_types_present? == false
  end
  
  def test_create_new_route    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)

    @b747 = Aircrafttype.find(2)
    assert_not_nil(@b747)

    @zrh_dep = DepartureAirport.find("ZRH")
    assert_not_nil(@zrh_dep)
            
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
            
    @iad_arr = ArrivalAirport.find("IAD")
    assert_not_nil(@iad_arr)
    
    @iad = Airport.find("IAD")
    assert_not_nil(@iad)
            
    @longer_miles = DistanceInMiles.new(4250)
    assert_not_nil(@longer_miles)

    @shorter_miles = DistanceInMiles.new(4228)
    assert_not_nil(@shorter_miles)

    config_params = [@a330,@zrh_dep, @iad_arr, @longer_miles]
    @route_creator = RouteCreator.new(config_params)
    assert_not_nil(@route_creator)
    assert @route_creator.required_param_types_present?
    
    @finished_route = @route_creator.manufacture
    assert_not_nil(@finished_route)
    assert @finished_route.dep_airport_obj == @zrh
    assert @finished_route.arr_airport_obj == @iad
    assert @finished_route.aircrafttype_id == @a330.id
    assert @finished_route.distance_miles == 4250

    config_params = [@a330, @zrh_dep, @iad_arr, @shorter_miles]
    @rc = RouteCreator.new(config_params)
    assert_not_nil(@rc)
    @route2 = @rc.manufacture
    assert_not_nil(@route2)
    assert @route2.distance_miles == 4228
  end
  
end
