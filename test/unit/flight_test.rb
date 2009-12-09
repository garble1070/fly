require File.dirname(__FILE__) + '/../test_helper'

class FlightTest < ActiveSupport::TestCase
  def test_basics
    @plane = Plane.find(1)
    assert_not_nil(@plane)
    
    @lax = DepartureAirport.find("LAX")
    assert_not_nil(@lax)
    
    @zrh = ArrivalAirport.find("ZRH")
    assert_not_nil(@zrh)
    
    @new_route = Route.find([@lax, @zrh])
    assert_not_nil(@new_route)
    
    @fc = FlightCreator.new([@plane, @new_route])
    assert_not_nil(@fc)
    
    @new_flight = @fc.manufacture
    @new_flight.save
    assert @new_flight.id > 0
    
    @boarding = BoardingDurationInSeconds.new(15)
    @taxi = TaxiDurationInSeconds.new(45)
    @inflight = InflightDurationInSeconds.new(500)
    @maintenance = MaintenanceDurationInSeconds.new(60)
    
    @fc << @boarding << @taxi << @inflight << @maintenance
    @new_flight2 = @fc.manufacture
    @new_flight2.save
    assert @new_flight2.id > 0
  end
end
