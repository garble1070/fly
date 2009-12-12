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
  
  def generate_url(distance=0)
    calculate_start_data
    @query.add_param("maptype","terrain")
    @query.add_param("format","jpg")
    @query.add_param("sensor","false")
    @query.add_param("size","#{@width}x#{@height}")
    @query.add_param("key","ABQIAAAAHjDfn4JyllVUPtyJ31qLhhSjmO-kHhwqX2l12pfya7ICKXzFqhRq3QRp0Ql03P59GaKmwMasDuskrA")
    @query.add_param("markers",start_marker_string)
    @query.add_param("markers",end_marker_string)
    @query.add_param("path",path_string)
    if distance > 0
      calculate_inflight_data
      @query.add_param("markers",inflight_marker_string)
      @query.add_param("path",inflight_path_string)
    end
    @query.output
  end
  
  def calculate_start_data
    start_lat = @route[0][:start_lat].for_output
    start_lng = @route[0][:start_lng].for_output
    @start_pair = start_lat + "," + start_lng
  end
  
  def start_marker_string
    output = "color:red|label:D|"
    output << @start_pair
    return output
  end
  
  def end_marker_string
    count = @route.length - 1
    output = "color:green|label:A|"
    end_lat = @route[count][:end_lat].for_output
    end_lng = @route[count][:end_lng].for_output
    output << (end_lat + "," + end_lng)
    return output
  end
  
  
  def inflight_marker_string
    count = @route.length - 1
    output = "color:yellow|"
    output << (@inflight_pair + "|")
    return output
  end

  def path_string
    output = "color:0x555555AA|weight:5|"
    output << (@start_pair + "|")
    @route.each do |segment|
      point_lat = segment[:end_lat].for_output
      point_lng = segment[:end_lng].for_output
      output << (point_lat + "," + point_lng + "|")
    end
    return output.chop
  end
  
  def inflight_path_string
    output = "color:0xFFFF00FF|weight:5|"
    output << (@start_pair + "|")
    @route.each do |segment|
      point_lat = segment[:end_lat].for_output
      point_lng = segment[:end_lng].for_output
      output << (point_lat + "," + point_lng + "|")
    end
    return output.chop
  end

   def calculate_inflight_data
     
   end
  
end

class Float
    def for_output
      self.round(3).to_s
  end
end
=begin
&markers=color:red|label:D|33.9425,-118.408
&markers=color:yellow|62.085,-66.4798
&markers=color:green|label:A|47.4647,8.549

&path=color:0xFFFF00FF|weight:5|33.9425,-118.40|50.767,-100.16|62.085,-66.479
&path=color:white|weight:5|33.9425,-118.40|50.767,-100.16|62.085,-66.479|60.51,-21.02|47.4647,8.549
=end

