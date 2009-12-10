require File.dirname(__FILE__) + '/../test_helper'

class PlaneCreatorTest < ActiveSupport::TestCase
  
  def test_basics
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @b747 = Aircrafttype.find(2)
    assert_not_nil(@b747)

    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
        
    @pc = PlaneCreator.new
    @pc.add_param(@a330)
    assert @pc.param_present?(@a330) == true
    assert @pc.param_present?(@b747) == false
    assert @pc.param_present?(@lax) == false
    assert @pc.param_by_classname("Aircrafttype") == @a330
    
    @pc.add_param(@b747)
    assert @pc.param_by_classname("Aircrafttype") == @b747    
    @pc.delete_param(@b747)
    assert_nil(@pc.param_by_classname("Aircrafttype"))
    
    assert @pc.param_classname_present?("Airport") == false
    @pc << @lax
    assert @pc.param_classname_present?("Airport") == true
    assert @pc.param_present?(@lax) == true
    @pc.delete_by_classname("Airport")
    assert @pc.param_classname_present?("Airport") == false
    
    @pc << @airline << @lax
    assert @pc.required_param_types_present? == false
    assert_raise(RuntimeError) {@pc.manufacture}
    @pc << @b747
    assert @pc.required_param_types_present? == true

  end
  
  def test_create_new_plane    
    @airline = Airline.find(1)
    assert_not_nil(@airline)
    
    @a330 = Aircrafttype.find(1)
    assert_not_nil(@a330)
    
    @b747 = Aircrafttype.find(2)
    assert_not_nil(@b747)

    @lax = Airport.find("LAX")
    assert_not_nil(@lax)
    
    @sixty_thousand_pax = StartingPaxCount.new(60000)
    assert_not_nil(@sixty_thousand_pax)
    
    @one_hundred_k_miles = StartingMilesCount.new(100000)
    assert_not_nil(@one_hundred_k_miles)
            
    config_params = [@airline,@a330,@lax, @sixty_thousand_pax, 
                          @one_hundred_k_miles, "City of Winterthur"]
    @plane_creator = PlaneCreator.new(config_params)
    assert_not_nil(@plane_creator)
    assert @plane_creator.required_param_types_present?
    
    @finished_plane = @plane_creator.manufacture
    assert_not_nil(@finished_plane)
    @finished_plane.save

    assert @finished_plane.airline == @airline
    assert @finished_plane.starting_airport == @lax
    assert @finished_plane.aircrafttype == @a330
    assert @finished_plane.starting_pax_count == 60000
    assert @finished_plane.starting_miles_count == 100000
    assert @finished_plane.name == "City of Winterthur"
    assert @finished_plane.avg_pax_load == @a330.avg_pax_load_default
    assert @finished_plane.avg_speed_knots == @a330.avg_speed_knots_default
    assert @finished_plane.range_miles == @a330.range_miles_default
    
    @plane_creator.delete_by_classname("StartingPaxCount")
    @plane_creator.delete_by_classname("StartingMilesCount")

    @finished_plane2 = @plane_creator.manufacture
    assert_not_nil(@finished_plane2)
    assert @finished_plane2.starting_pax_count == 0
    assert @finished_plane2.starting_miles_count == 0

  end
  
  
end
