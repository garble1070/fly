require File.dirname(__FILE__) + '/../test_helper'

class PlaneTest < ActiveSupport::TestCase
  
  def test_associations
    @plane = Plane.find(1)
    @flight = Flight.find(220)
    assert_not_nil(@plane)
    assert_not_nil(@flight)
    my_planes_flights = @plane.flights
    assert_kind_of(Array,my_planes_flights) 
    assert my_planes_flights.include?(@flight)
    assert @flight.plane == @plane
  end

end
