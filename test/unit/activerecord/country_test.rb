require File.dirname(__FILE__) + '/../../test_helper'

class CountryTest < ActiveSupport::TestCase
  def load_instance_vars
    @us = Country.find("US")
    @ch = Country.find("CH")
    @lax = Airport.find("LAX")
    @airline_1 = Airline.find(1)
  end

  def test_associations_with_airport_class
    load_instance_vars
    assert_not_nil(@us)
    assert_not_nil(@lax)

    my_countrys_airports = @us.airports
    assert_kind_of(Array,my_countrys_airports) 
    assert_equal(true,my_countrys_airports.include?(@lax))
    assert_equal(@lax.country,@us)
  end
  
  def test_associations_with_airline_class
    load_instance_vars
    assert_not_nil(@ch)
    assert_not_nil(@airline_1)

    my_countrys_airlines = @ch.airlines
    assert_kind_of(Array,my_countrys_airlines) 
    assert_equal(true,my_countrys_airlines.include?(@airline_1))
    assert_equal(@airline_1.country,@ch)
  end


end
