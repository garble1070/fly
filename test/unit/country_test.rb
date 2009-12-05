require File.dirname(__FILE__) + '/../test_helper'

class CountryTest < ActiveSupport::TestCase

  def test_associations_with_airport_class
    @country = Country.get("US")
    assert_not_nil(@country)

    @airport = Airport.get("LAX")
    assert_not_nil(@airport)

    my_countrys_airports = @country.airports
    assert_kind_of(Array,my_countrys_airports) 
    assert my_countrys_airports.include?(@airport)

    assert @airport.country_obj == @country
    assert @airport.country == @country
  end
  
  def test_associations_with_airline_class
    @country = Country.get("CH")
    assert_not_nil(@country)

    @airline = Airline.find(1)
    assert_not_nil(@airline)

    my_countrys_airlines = @country.airlines
    assert_kind_of(Array,my_countrys_airlines) 
    assert my_countrys_airlines.include?(@airline)

    assert @airline.country_obj == @country
    assert @airline.country == @country
  end


end
