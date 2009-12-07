require File.dirname(__FILE__) + '/../test_helper'

class PlaneCreatorTest < ActiveSupport::TestCase
  
  
  def test_create_new_plane_better
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @b747 = Aircrafttype.find(2)
    assert_not_nil(@b747)

    @lax = Airport.get("LAX")
    assert_not_nil(@lax)
    
    @sixty_thousand_pax = StartingPaxCount.new(60000)
    assert_not_nil(@sixty_thousand_pax)
    
    @one_hundred_k_miles = StartingMilesCount.new(100000)
    assert_not_nil(@one_hundred_k_miles)
    
    @pc = PlaneCreator.new
    @pc.add_param(@a330)
    assert @pc.param_present?(@a330) == true
    assert @pc.param_present?(@b747) == false
    assert @pc.param_present?(@lax) == false
    assert @pc.find_by_classname("Aircrafttype") == @a330
    
    @pc.add_param(@b747)
    assert @pc.find_by_classname("Aircrafttype") == @b747    
    @pc.delete_param(@b747)
    assert_nil(@pc.find_by_classname("Aircrafttype"))
    
    assert @pc.param_classname_present?("Airport") == false
    @pc << @lax
    assert @pc.param_classname_present?("Airport") == true
    assert @pc.param_present?(@lax) == true
    @pc.delete_by_classname("Airport")
    assert @pc.param_classname_present?("Airport") == false
    
    config_params = [@airline,@a330,@lax, @sixty_thousand_pax, @one_hundred_k_miles]
    @plane_creator = PlaneCreator.new(config_params)
    assert_not_nil(@plane_creator)
    assert @plane_creator.required_param_types_present?
    
    
    
    incomplete_config_params = [@airline,@a330]
    @plane_creator = PlaneCreator.new(incomplete_config_params)
    assert_not_nil(@plane_creator)
    assert_raise(RuntimeError) {@plane_creator.manufacture_item}

  end
  
  
end
