require File.dirname(__FILE__) + '/../../test_helper'

class MapPathTest < ActiveSupport::TestCase
  def test_basic
    @jfk = Airport.find("jfk")
    @cdg = Airport.find("cdg")
    @flight_plan = FlightPlan.new_with_all_data(@jfk,@cdg)
    
    @path = MapPath.new(@flight_plan)
    assert_not_nil(@path)
    
    assert_equal(@path.weight,5)
    @path.weight = 7
    assert_equal(@path.weight,7)
    
    assert_equal(@path.color,"white")
    @path.color = "red"
    assert_equal(@path.color,"red")
    
    assert_equal(@path.color_to_s,"color:red|")
    assert_equal(@path.weight_to_s,"weight:7|")
    assert_equal(@path.to_s,"color:red|weight:7|40.6398,-73.7789|42.5365896618961,-70.2020531741765|44.31533045779,-66.4083735962207|45.9608703763424,-62.3867787515533|47.4569885918017,-58.1306432088922|48.7867337032247,-53.6396395148434|49.932951109949,-48.9216612752484|50.8790111388618,-43.9945301064262|51.6097131797241,-38.8870761059281|52.1122914921985,-33.6391456421625|52.377397463426,-28.3001961900288|52.3999009075093,-22.9264117745025|52.1793598079632,-17.5766570902617|51.7200617958817,-12.3079413140639|51.0306285398321,-7.17122293912323|50.1232653352141,-2.20827479245397|49.0128,2.55")
    assert_equal(@path.to_s_rnd,"color:red|weight:7|40.64,-73.779|42.537,-70.202|44.315,-66.408|45.961,-62.387|47.457,-58.131|48.787,-53.64|49.933,-48.922|50.879,-43.995|51.61,-38.887|52.112,-33.639|52.377,-28.3|52.4,-22.926|52.179,-17.577|51.72,-12.308|51.031,-7.171|50.123,-2.208|49.013,2.55")
    
  end
end
