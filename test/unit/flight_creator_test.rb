require File.dirname(__FILE__) + '/../test_helper'

class FlightCreatorTest < ActiveSupport::TestCase
  
  def test_basics
    @plane = Plane.find(1)
    assert_not_nil(@plane)
    
    @lax = DepartureAirport.find("LAX")
    assert_not_nil(@lax)

    @zrh = ArrivalAirport.find("ZRH")
    assert_not_nil(@zrh)

    @iad = ArrivalAirport.find("IAD")
    assert_not_nil(@iad)

    @fc = FlightCreator.new([@plane, @lax, @zrh])
    assert_not_nil(@fc)
    
    @new_flight = @fc.manufacture
    @new_flight.save
    assert @new_flight.id > 0
    
    assert @new_flight.boarding_duration == 60
    assert @new_flight.taxi_duration == 70
    assert @new_flight.maintenance_duration ==  80
    assert @new_flight.inflight_duration.to_int == 37100
    
    @boarding = BoardingDurationInSeconds.new(15)
    @taxi = TaxiDurationInSeconds.new(45)
    @maintenance = MaintenanceDurationInSeconds.new(120)
    
    @fc << @boarding << @taxi << @maintenance << @iad
    @new_flight2 = @fc.manufacture
    @new_flight2.save
    assert @new_flight2.id > 0
    
    assert @new_flight2.boarding_duration == 15
    assert @new_flight2.taxi_duration == 45
    assert @new_flight2.maintenance_duration ==  120
    assert @new_flight2.inflight_duration.to_int == 14296
    
  end
  
end
