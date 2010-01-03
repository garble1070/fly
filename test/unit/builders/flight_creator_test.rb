require File.dirname(__FILE__) + '/../../test_helper'

class FlightCreatorTest < ActiveSupport::TestCase
  
  def test_basics
    load_instance_vars
    
    @fc = FlightCreator.new([@plane_1, @dep_airport_lax, @arr_airport_zrh])
    assert_not_nil(@fc)
    
    @new_flight = @fc.manufacture
    @new_flight.save
    assert @new_flight.id > 0
    
    assert_equal(60,@new_flight.boarding_duration)
    assert_equal(70,@new_flight.taxi_duration)
    assert_equal(37100,@new_flight.inflight_duration.to_int)
    assert_equal(@lax,@new_flight.dep_airport)
    assert_equal(@zrh,@new_flight.arr_airport)
    assert_equal(5930,@new_flight.flight_miles)
    assert_equal(240,@new_flight.pax_count)
    assert_equal(45.47,@new_flight.payload_value_flc)
    
    @boarding = BoardingDurationInSeconds.new(15)
    @taxi = TaxiDurationInSeconds.new(45)
    @pax_count_200 = PaxCount.new(200)
    @payload_value_flc_150 = PayloadValueFlc.new(150)
    @flight_miles_4000 = FlightMiles.new(4000)
    
    @fc << @boarding << @taxi << @arr_airport_iad << @flight_miles_4000
    @fc << @pax_count_200 << @payload_value_flc_150
    @new_flight2 = @fc.manufacture
    @new_flight2.save
    assert @new_flight2.id > 0
    
    assert_equal(@new_flight2.boarding_duration,15)
    assert_equal(@new_flight2.taxi_duration,45)
    assert_equal(@new_flight2.inflight_duration.to_int,14296)
    assert_equal(@new_flight2.dep_airport,@lax)
    assert_equal(@new_flight2.arr_airport,@iad)
    assert_equal(200,@new_flight2.pax_count)
    assert_equal(150,@new_flight2.payload_value_flc)
  end
end
  