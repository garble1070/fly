require '../test_helper'

class CountryTest < ActiveSupport::TestCase

  def test_associations
    @country = Country.find("US")
    @airport = Airport.find("LAX")
    assert_not_nil(@country)
    assert_not_nil(@airport)
    my_countrys_airports = @country.airports
    assert_kind_of(Array,my_countrys_airports) 
    assert my_countrys_airports.include?(@airport)
    
    @country1 = Country.find("CH")
    @airline = Airline.find(1)
    assert_not_nil(@country1)
    assert_not_nil(@airline)
    my_countrys_airlines = @country1.airlines
    assert_kind_of(Array,my_countrys_airlines) 
    assert my_countrys_airlines.include?(@airline)
  end


end
