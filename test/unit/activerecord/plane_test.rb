require File.dirname(__FILE__) + '/../../test_helper'

class PlaneTest < ActiveSupport::TestCase
  
  
  def test_associations_with_flight_class
    load_instance_vars
    
    my_planes_flights = @plane_1.flights
    assert_kind_of(Array,my_planes_flights) 
    assert my_planes_flights.include?(@flight_220)
    assert_equal(@plane_1,@flight_220.plane)
  end
  
  def test_trigger_new_flight
    load_instance_vars
    
    @fc = FlightCreator.new([@plane_1, @dep_airport_lax, @arr_airport_zrh])
    @new_flight = @fc.manufacture    
    @new_flight3 = @plane_1.trigger_new_flight(@lax, @zrh)
    
    assert @new_flight3.id > 0
    assert_equal(@new_flight.dep_airport_code, @new_flight3.dep_airport.code)
    assert_equal(@new_flight.arr_airport_code, @new_flight3.arr_airport.code)
    assert_equal(@new_flight.plane_id, @new_flight3.plane_id)
  end
  
  def test_account
    load_instance_vars
    assert_equal(@plane_1.owners_flc_account,@account_1)
  end
  
  
end
