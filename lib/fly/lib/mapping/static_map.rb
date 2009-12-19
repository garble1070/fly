class StaticMap
  attr_reader :map_width, :map_height
  
  
  # Assigns arguments for width and height to the appropriate instance variables
  def set_size(width,height)
    @map_width = width
    @map_height = height
  end
  
  # Inserts common param data for all static maps
  def insert_basic_params_common
    @query.add_param("maptype","terrain")
    @query.add_param("format","jpg")
    @query.add_param("sensor","false")
    @query.add_param("size","#{@map_width}x#{@map_height}")
    @query.add_param("key",GOOGLE_MAPS_STATIC_API_KEY)
  end
  
  # Abstract method to set common variables and output the end result
  def complete_url_generator(&block)
    @query = QueryCollectionNonExclusiveKey.new
    insert_basic_params_common
    insert_basic_params_for_map_subclass
    block.call
    @query.output
  end
  
    # Meant to be overridden
  def insert_basic_params_for_map_subclass
    FlyError::raise_superclass_error
  end
  
end
