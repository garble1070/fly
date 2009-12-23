require File.dirname(__FILE__) + '/../../test_helper'

class FlightTest < ActiveSupport::TestCase
  def test_status
    load_instance_vars
    @flight_221.boarding_start_time = nil
    @flight_221.boarding_duration = 1200
    @flight_221.taxi_duration = 1200
    @flight_221.inflight_duration = 7200
    @flight_221.flight_completed_time = nil

    assert_equal(:not_yet_scheduled,@flight_221.status)

    @ten_mins_from_now = Time.at(Time.now.to_i + 600)
    @flight_221.boarding_start_time = @ten_mins_from_now
    assert_equal(:scheduled,@flight_221.status)
    
    @ten_mins_ago = Time.at(Time.now.to_i - 600)
    @flight_221.boarding_start_time = @ten_mins_ago
    assert_equal(:boarding,@flight_221.status)

    @thirty_mins_ago = Time.at(Time.now.to_i - 1800)
    @flight_221.boarding_start_time = @thirty_mins_ago
    assert_equal(:departed_gate,@flight_221.status)

    @one_hour_ago = Time.at(Time.now.to_i - 3600)
    @flight_221.boarding_start_time = @one_hour_ago
    assert_equal(:in_flight,@flight_221.status)

    @three_hours_ago = Time.at(Time.now.to_i - 10800)
    @flight_221.boarding_start_time = @three_hours_ago
    assert_equal(:arrived,@flight_221.status)

    @flight_221.flight_completed_time = @ten_mins_ago
    assert_equal(:completed,@flight_221.status)

 end
end
