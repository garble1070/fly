require File.dirname(__FILE__) + '/../../test_helper'

class FlightPlanTest < ActiveSupport::TestCase
  
  def test_basic_instance_vars
    load_instance_vars
    
    @flight_plan = FlightPlan.new(@lax,@zrh)
    assert_not_nil(@flight_plan)
    
    assert_equal(@flight_plan.distance.round(3),5930.850)
    assert_equal(@flight_plan.heading.round(3),32.800)
    assert_equal(@flight_plan.dep_airport,@lax)
    assert_equal(@flight_plan.arr_airport,@zrh)
  end
  
  def test_reset_routing
    load_instance_vars
    
    @flight_plan = FlightPlan.new(@lax,@zrh)
    assert_not_nil(@flight_plan)
    assert_nil(@flight_plan.segment_series)
    
    @flight_plan.reset_routing
    @my_segment = FlightSegment.new(@lax,@zrh)
    my_series = SegmentSeries.new
    my_series << @my_segment
    instance_vars_to_check = ["@start_obj","@end_obj","@odometer"]
    instance_vars_to_check.each do |varname|
      assert_equal(@flight_plan.segment_series[0].instance_variable_get(varname),
      my_series[0].instance_variable_get(varname))
    end
  end
  
  def test_split_segment_and_series
    load_instance_vars

    @flight_plan = FlightPlan.new(@lax,@zrh)    
    @my_segment = FlightSegment.new(@lax,@zrh)
    @more_granular_series = @flight_plan.split_segment(@my_segment)
    assert_not_nil(@more_granular_series)
    
    midpoint = @lax.midpoint_to(@zrh)
    first_half = @more_granular_series[0]
    second_half = @more_granular_series[1]
    
    assert_equal(first_half.start_obj,@lax)
    assert_equal(first_half.end_obj.lng,midpoint.lng)
    assert_equal(first_half.end_obj.lat,midpoint.lat)
    assert_equal(second_half.start_obj.lng,midpoint.lng)
    assert_equal(second_half.start_obj.lat,midpoint.lat)
    assert_equal(second_half.end_obj,@zrh)
    
    my_series = SegmentSeries.new
    my_series << @my_segment    
    @flight_plan.split_series(my_series)
    assert_not_nil(@flight_plan.segment_series)
    
    assert_equal(@flight_plan.segment_series.length,2)
    assert_equal(@flight_plan.segment_series[0].odometer.round(3),2965.425)   
    assert_equal(@flight_plan.segment_series[1].odometer.round(3),5930.850)  
  end
  
  def test_iterator_count
    load_instance_vars
    
    @flight_plan = FlightPlan.new(@lax,@zrh)    
    assert_equal(@flight_plan.iterator_count,5)
    
    @flight_plan = FlightPlan.new(@lax,@sfo)    
    assert_equal(@flight_plan.iterator_count,1)
    
    @flight_plan = FlightPlan.new(@lax,@iad)    
    assert_equal(@flight_plan.iterator_count,3)
  end
  
  def test_new_with_all_data
    load_instance_vars

    @flight_plan = FlightPlan.new_with_all_data(@lax,@zrh)
    seg_series = @flight_plan.segment_series
    assert_not_nil(seg_series)
    
    assert_equal(seg_series.length,32)
    assert_equal(seg_series[0].odometer.round(3),185.339)
    assert_equal(seg_series[0].end_obj.lat.round(3),36.182)
    assert_equal(seg_series[0].end_obj.lng.round(3),-116.61)
    assert_equal(seg_series[7].odometer.round(3),1482.713)
    assert_equal(seg_series[7].start_obj.lat.round(3),48.845)
    assert_equal(seg_series[7].start_obj.lng.round(3),-103.06)
    assert_equal(seg_series[30].odometer.round(3),5745.511)
    assert_equal(seg_series[30].start_obj.lat.round(3),51.335)
    assert_equal(seg_series[30].start_obj.lng.round(3),2.846)
    
  end
  
end
