require File.dirname(__FILE__) + '/../test_helper'

class PlaneCreatorTest < ActiveSupport::TestCase
  
  
  def test_create_new_plane_better
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @lax = Airport.get("LAX")
    assert_not_nil(@lax)
    
    @sixty_thousand_pax = StartingPaxCount.new(60000)
    assert_not_nil(@sixty_thousand_pax)
    
    @one_hundred_k_miles = StartingMilesCount.new(100000)
    assert_not_nil(@one_hundred_k_miles)
        
    config_params = [@airline,@a330,@lax, @sixty_thousand_pax, @one_hundred_k_miles]
    @plane_creator = PlaneCreator.new(config_params)
    
  end
  
  
end
