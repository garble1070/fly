require File.dirname(__FILE__) + '/../../test_helper'

class PlaneTest < ActiveSupport::TestCase
  
  def test_associations_with_flight_class
    @plane = Plane.find(1)
    assert_not_nil(@plane)

    @flight = Flight.find(220)
    assert_not_nil(@flight)

    my_planes_flights = @plane.flights
    assert_kind_of(Array,my_planes_flights) 
    assert my_planes_flights.include?(@flight)

    assert @flight.plane == @plane
  end
    
  def test_trigger_new_flight
    @plane = Plane.find(1)
    assert_not_nil(@plane)
    
    @lax = DepartureAirport.find("LAX")
    assert_not_nil(@lax)

    @zrh = ArrivalAirport.find("ZRH")
    assert_not_nil(@zrh)

    @fc = FlightCreator.new([@plane, @lax, @zrh])
    assert_not_nil(@fc)
    
    @new_flight = @fc.manufacture    
    @new_flight3 = @plane.trigger_new_flight([@lax, @zrh])
    
    assert @new_flight3.id > 0
    assert_equal(@new_flight.dep_airport_code, @new_flight3.dep_airport.code)
    assert_equal(@new_flight.arr_airport_code, @new_flight3.arr_airport.code)
    assert_equal(@new_flight.plane_id, @new_flight3.plane_id)
    
  end
  
  def test_account
    @plane = Plane.find(1)
    assert_not_nil(@plane)

    @account = Account.find(1)
    assert_not_nil(@account)

    assert_equal(@plane.owners_flc_account,@account)
  end


end
