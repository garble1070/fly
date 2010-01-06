require File.dirname(__FILE__) + '/../../test_helper'

class CountryTest < ActiveSupport::TestCase
  def test_associations_with_airport_class
    load_instance_vars

    my_countrys_airports = @us.airports
    assert_kind_of(Array,my_countrys_airports) 
    assert_equal(true,my_countrys_airports.include?(@lax))
    assert_equal(@lax.country,@us)
  end
  
  def test_associations_with_airline_class
    load_instance_vars

    my_countrys_airlines = @ch.airlines
    assert_kind_of(Array,my_countrys_airlines) 
    assert_equal(true,my_countrys_airlines.include?(@airline_1))
    assert_equal(@airline_1.country,@ch)
  end


end
