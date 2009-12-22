require File.dirname(__FILE__) + '/../../test_helper'

class PlaneCreatorTest < ActiveSupport::TestCase
  
  def test_basics
    load_instance_vars    
        
    @pc = PlaneCreator.new
    @pc.add_param(@a330)
    assert_equal(@pc.param_present?(@a330),true)
    assert_equal(@pc.param_present?(@b747),false)
    assert_equal(@pc.param_present?(@lax),false)
    assert_equal(@pc.param_by_classname("Aircrafttype"),@a330)
    
    @pc.add_param(@b747)
    assert_equal(@pc.param_by_classname("Aircrafttype"),@b747)   
    @pc.delete_param(@b747)
    assert_nil(@pc.param_by_classname("Aircrafttype"))
    
    assert_equal(@pc.param_classname_present?("Airport"),false)
    @pc << @lax
    assert_equal(@pc.param_classname_present?("Airport"),true)
    assert_equal(@pc.param_present?(@lax),true)
    @pc.delete_by_classname("Airport")
    assert_equal(@pc.param_classname_present?("Airport"),false)
    
    @pc << @airline_1 << @lax
    assert_equal(@pc.required_param_types_present?,false)
    assert_raise(RuntimeError) {@pc.manufacture}
    @pc << @b747
    assert_equal(@pc.required_param_types_present?,true)

  end
  
  def test_create_new_plane    
    load_instance_vars
    
    config_params = [@airline_1,@a330,@lax, @sixty_thousand_pax, 
                          @one_hundred_k_miles, "City of Winterthur"]
    @plane_creator = PlaneCreator.new(config_params)
    assert_not_nil(@plane_creator)
    assert_equal(@plane_creator.required_param_types_present?,true)
    
    @finished_plane = @plane_creator.manufacture
    assert_not_nil(@finished_plane)
    @finished_plane.save

    assert_equal(@finished_plane.airline,@airline_1)
    assert_equal(@finished_plane.starting_airport,@lax)
    assert_equal(@finished_plane.aircrafttype,@a330)
    assert_equal(@finished_plane.starting_pax_count,60000)
    assert_equal(@finished_plane.starting_miles_count,100000)
    assert_equal(@finished_plane.name,"City of Winterthur")
    assert_equal(@finished_plane.avg_pax_load,@a330.avg_pax_load_default)
    assert_equal(@finished_plane.avg_speed_knots,@a330.avg_speed_knots_default)
    assert_equal(@finished_plane.range_miles,@a330.range_miles_default)
    assert_equal(@finished_plane.acquisition_cost,@a330.cost)
    
    @plane_creator.delete_by_classname("StartingPaxCount")
    @plane_creator.delete_by_classname("StartingMilesCount")

    @finished_plane2 = @plane_creator.manufacture
    assert_not_nil(@finished_plane2)
    assert_equal(@finished_plane2.starting_pax_count,0)
    assert_equal(@finished_plane2.starting_miles_count,0)


    
  end
  
  
end
