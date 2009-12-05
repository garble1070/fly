require File.dirname(__FILE__) + '/../test_helper'

class RouteTest < ActiveSupport::TestCase
    
  def test_associations_with_flight_class
    @route = Route.find(2)
    assert_not_nil(@route)

    @flight = Flight.find(221)
    assert_not_nil(@flight)

    my_routes_flights = @route.flights
    assert_kind_of(Array,my_routes_flights) 
    assert my_routes_flights.include?(@flight)

    assert @flight.route_obj == @route
    assert @flight.route == @route
  end

  def test_retrieve
    @zrh = Airport.get("ZRH")
    assert_not_nil(@zrh)
    
    @iad = Airport.get("IAD")
    assert_not_nil(@iad)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @b747 = Aircrafttype.find(2)
    assert_not_nil(@b747)
    
    @route1 = Route.get(@zrh,@iad,@a330)
    assert_not_nil(@route1)
    assert @route1.distance_miles == 4250

    @route2 = Route.get(@zrh,@iad,@b747)
    assert_not_nil(@route2)
    assert @route2.distance_miles == 4228

    assert_raise(ArgumentError){Route.get(@zrh,@zrh,@b747)}
    assert_raise(ArgumentError){Route.get(@zrh,nil,@b747)}
    assert_raise(ArgumentError){Route.get(@zrh,@iad,nil)}
    assert_raise(RuntimeError){Route.get(Airport.new,@iad,@b747)}
    assert_raise(RuntimeError){Route.get(@zrh,Airport.new,@b747)}
    assert_raise(RuntimeError){Route.get(@zrh,@iad,Aircrafttype.new)}

  end
end
