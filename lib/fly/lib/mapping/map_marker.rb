class MapMarker
  
  attr_accessor :label, :color
  
  def initialize(waypoint,label=nil)
    @waypoint = waypoint
    @color = "white"
    @label = label
    return self
  end
  
  def to_s
    color_to_s + label_to_s + @waypoint.to_s
  end
  
  def to_s_rnd
    color_to_s + label_to_s + @waypoint.to_s_rnd
  end

  def color_to_s
    "color:#{@color}|"
  end
  
  def label_to_s
   @label ? "label:#{@label}|" : ""
  end
  
end