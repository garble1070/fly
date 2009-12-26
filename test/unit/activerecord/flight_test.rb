require File.dirname(__FILE__) + '/../../test_helper'

class FlightTest < ActiveSupport::TestCase
  def test_links_to_airport_class
    load_instance_vars
    assert_equal(@sfo,@flight_220.dep_airport)
    assert_equal(@jfk,@flight_220.arr_airport)
  end
  
  def test_status
    load_instance_vars
    @flight_221.boarding_start_time = nil
    @flight_221.boarding_duration = 1200
    @flight_221.taxi_duration = 1200
    @flight_221.inflight_duration = 7200
    @flight_221.flight_completed_time = nil
    
    assert_equal(:not_yet_scheduled,@flight_221.update_status.status_snapshot)
    
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
  
end
