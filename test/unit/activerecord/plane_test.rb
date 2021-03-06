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
    assert_equal(@plane_1.my_account,@account_1)
  end
  
  def test_update_status_and_location
    load_instance_vars
    updated_plane = @plane_1.update_status_and_location
    assert_equal(:available,updated_plane.status_snapshot)
    assert_equal(@jfk,updated_plane.location_snapshot)
    
    updated_plane = @plane_2.update_status_and_location
    assert_equal(:arrived,updated_plane.status_snapshot)
    assert_equal(@dfw,updated_plane.location_snapshot)
  end
  
  def test_plane_with_no_flights
    load_instance_vars
    @new_plane = @airline_3.acquire_new_plane(@b747)
    updated_plane = @new_plane.update_status_and_location
    assert_equal(:available,updated_plane.status_snapshot)
    assert_equal(@iad,updated_plane.location_snapshot)
  end
  
  def test_pax_count_tally
    load_instance_vars
    assert_equal(960,@plane_2.get_tally_by_column_name("pax_count"))
  end

  def test_flight_miles_tally
    load_instance_vars
    assert_equal(11405,@plane_2.get_tally_by_column_name("flight_miles"))
  end

  def test_flight_segment_tally
    load_instance_vars
    assert_equal(3,@plane_2.flight_segment_tally)
  end

end
