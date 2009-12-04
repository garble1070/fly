require '../test_helper'

class RouteTest < ActiveSupport::TestCase
  
  def test_link_to_airports
    @route = Route.find(1)
    assert_not_nil(@route)

    dep_airport_lax = @route.dep_airport
    assert_not_nil(dep_airport_lax)
    @lax = Airport.find("LAX")
    assert dep_airport_lax == @lax

    arr_airport_zrh = @route.arr_airport
    assert_not_nil(arr_airport_zrh)
    @zrh = Airport.find("ZRH")
    assert arr_airport_zrh == @zrh
end
  
  def test_identify
    @zrh = Airport.find("ZRH")
    assert_not_nil(@zrh)
    @iad = Airport.find("IAD")
    assert_not_nil(@iad)
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    @b747 = Aircrafttype.find(2)
    assert_not_nil(@b747)
    
    @route1 = Route.identify(@zrh,@iad,@a330)
    assert_not_nil(@route1)
    miles1 = @route1.distance_miles
    assert miles1 == 4250

    @route2 = Route.identify(@zrh,@iad,@b747)
    assert_not_nil(@route2)
    miles2 = @route2.distance_miles
    assert miles2 == 4228

    assert_raise(ArgumentError){Route.identify(@zrh,@zrh,@b747)}
    assert_raise(ArgumentError){Route.identify(@zrh,nil,@b747)}
    assert_raise(ArgumentError){Route.identify(@zrh,@iad,nil)}

  end
end
