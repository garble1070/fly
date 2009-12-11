class StaticMap
  
end

class FlightMap < StaticMap
  def initialize(route)
    @route = route
    @query = QueryCollection.new
    @width = 450
    @height = 300
  end
  
  def add_route(route)
    @route = route
  end
  
  def set_size(width,height)
    @width = width
    @height = height
  end
  
  def generate_url
    @query.add_param("maptype","terrain")
    @query.add_param("sensor","false")
    @query.add_param("size","#{@width}x#{@height}")
    @query.add_param("key","ABQIAAAAHjDfn4JyllVUPtyJ31qLhhQ8nda2l8z-oXOZMhvo4DA8FzaARRQyw1ds0Bo_wIju_tu5BS3IEbvfoA")
    @query.add_param("markers",start_marker_string)
    @query.add_param("markers",end_marker_string)
    @query.add_param("path",path_string)
    @query.output
  end
  
  def start_marker_string
    output = "color:red|label:D|"
    start_lat = @route[0][:start_lat]
    start_lng = @route[0][:start_lng]
    output << (start_lat.to_s + "," + start_lng.to_s)
    return output
  end
  
  def end_marker_string
    count = @route.length - 1
    output = "color:green|label:A|"
    end_lat = @route[count][:end_lat]
    end_lng = @route[count][:end_lng]
    output << (end_lat.to_s + "," + end_lng.to_s)
    return output
  end
  
  def path_string
    output = "color:white|weight:5|"
    start_lat = @route[0][:start_lat]
    start_lng = @route[0][:start_lng]
    output << (start_lat.to_s + "," + start_lng.to_s + "|")
    @route.each do |segment|
      point_lat = segment[:end_lat]
      point_lng = segment[:end_lng]
      output << (point_lat.to_s + "," + point_lng.to_s + "|")
    end
    return output.chop
  end
  
  
end


=begin
&markers=color:red|label:D|33.9425,-118.408
&markers=color:yellow|62.085,-66.4798
&markers=color:green|label:A|47.4647,8.549

&path=color:0xFFFF00FF|weight:5|33.9425,-118.40|50.767,-100.16|62.085,-66.479
&path=color:white|weight:5|33.9425,-118.40|50.767,-100.16|62.085,-66.479|60.51,-21.02|47.4647,8.549
=end

