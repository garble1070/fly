require File.dirname(__FILE__) + '/../../test_helper'

class FlightTest < ActiveSupport::TestCase
  def test_links_to_airport_class
    load_instance_vars
    assert_equal(@sfo,@flight_220.dep_airport)
    assert_equal(@jfk,@flight_220.arr_airport)
  end
  
  def flight_timing_test_basics
    load_instance_vars
    @flight_221.boarding_start_time = nil
    @flight_221.boarding_duration = 1200
    @flight_221.taxi_duration = 1200
    @flight_221.inflight_duration = 7627
    @flight_221.flight_completed_time = nil
  end
  
  def test_status
    flight_timing_test_basics
    assert_equal(:assigned_to_route,@flight_221.update_status.status_snapshot)
    
    @ten_mins_from_now = Time.at(Time.now.to_i + 600)
    @flight_221.boarding_start_time = @ten_mins_from_now
    assert_equal(:scheduled,@flight_221.update_status.status_snapshot)
    
    @ten_mins_ago = Time.at(Time.now.to_i - 600)
    @flight_221.boarding_start_time = @ten_mins_ago
    assert_equal(:boarding,@flight_221.update_status.status_snapshot)
    
    @thirty_mins_ago = Time.at(Time.now.to_i - 1800)
    @flight_221.boarding_start_time = @thirty_mins_ago
    assert_equal(:departed_gate,@flight_221.update_status.status_snapshot)
    
    @one_hour_ago = Time.at(Time.now.to_i - 3600)
    @flight_221.boarding_start_time = @one_hour_ago
    assert_equal(:in_flight,@flight_221.update_status.status_snapshot)
    
    @three_hours_ago = Time.at(Time.now.to_i - 10800)
    @flight_221.boarding_start_time = @three_hours_ago
    assert_equal(:arrived,@flight_221.update_status.status_snapshot)
    
    @flight_221.flight_completed_time = @ten_mins_ago
    assert_equal(:completed,@flight_221.update_status.status_snapshot)
    
  end
  
  def test_active_flights
    load_instance_vars
    active_flights = @airline_3.active_flights
    assert_equal(true,active_flights.include?(@flight_221))
    assert_equal(false,active_flights.include?(@flight_222))
  end
  
  def test_completed_flights
    load_instance_vars
    completed_flights = @airline_3.completed_flights
    assert_equal(false,completed_flights.include?(@flight_221))
    assert_equal(true,completed_flights.include?(@flight_222))
  end
  
  def test_all_flights
    load_instance_vars
    all_flights = @airline_3.all_flights
    assert_equal(true,all_flights.include?(@flight_221))
    assert_equal(true,all_flights.include?(@flight_222))
    assert all_flights[0].created_at < all_flights[1].created_at
    assert all_flights[1].created_at < all_flights[2].created_at
  end
  
  def test_distance_capped_at_route_length
    load_instance_vars
    flight_distance = DistanceInMiles.new(5000)
    result_obj = @flight_220.distance_capped_at_route_length(flight_distance)
    assert_equal(2582,result_obj.in_miles.to_int)
  end
  
  def test_inflight_position
    flight_timing_test_basics
    setup_one_hour_ago_params
    assert_equal(@approx_lat,@flight_221.inflight_position.lat.round(1))
    assert_equal(@approx_lng,@flight_221.inflight_position.lng.round(1))
  end
  
  def setup_one_hour_ago_params
    @one_hour_ago = Time.at(Time.now.to_i - 3600)
    @flight_221.boarding_start_time = @one_hour_ago
    @approx_lat = 33.9
    @approx_lng = -114.8
  end
  
  def test_location
    flight_timing_test_basics
    assert_equal(@lgb,@flight_221.update_location.location_snapshot)
    
    @ten_mins_from_now = Time.at(Time.now.to_i + 600)
    @flight_221.boarding_start_time = @ten_mins_from_now
    assert_equal(@lgb,@flight_221.update_location.location_snapshot)
    
    @ten_mins_ago = Time.at(Time.now.to_i - 600)
    @flight_221.boarding_start_time = @ten_mins_ago
    assert_equal(@lgb,@flight_221.update_location.location_snapshot)
    
    @thirty_mins_ago = Time.at(Time.now.to_i - 1800)
    @flight_221.boarding_start_time = @thirty_mins_ago
    assert_equal(@lgb.latlng,@flight_221.update_location.location_snapshot)
    
    setup_one_hour_ago_params
    assert_equal(@approx_lat,@flight_221.update_location.location_snapshot.lat.round(1))
    assert_equal(@approx_lng,@flight_221.update_location.location_snapshot.lng.round(1))
    
    @three_hours_ago = Time.at(Time.now.to_i - 10800)
    @flight_221.boarding_start_time = @three_hours_ago
    assert_equal(@dfw,@flight_221.update_location.location_snapshot)
    
    @flight_221.flight_completed_time = @ten_mins_ago
    assert_equal(@dfw,@flight_221.update_location.location_snapshot)
    
  end
  
  def test_update_status_and_location
    load_instance_vars
    updated_flight = @flight_221.update_status_and_location
    assert_equal(:arrived,updated_flight.status_snapshot)
    assert_equal(@dfw,updated_flight.location_snapshot)
  end
end
