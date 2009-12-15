class MapPath
  
  attr_accessor :weight, :color
  
  def initialize(flight_plan)
    @flight_plan = flight_plan
    @color = "white"
    @weight = 5
    return self
  end
  
  def to_s
    color_to_s + weight_to_s + @flight_plan.to_s
  end
  
  def to_s_rnd
    color_to_s + weight_to_s + @flight_plan.to_s_rnd
  end

  def color_to_s
    "color:#{@color}|"
  end
  
  def weight_to_s
   "weight:#{@weight}|"
  end
    
end