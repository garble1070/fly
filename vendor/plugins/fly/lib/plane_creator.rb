# Used to create a plane using configuration objects
class PlaneCreator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Constructor
  def initialize(config_params=[])
    @config_params = config_params
    @config_param_types = config_params.collect do |obj|
      obj.class.name
    end
  end
  
  # Adds individual objects to the '@config_params' array; if one of that type
  # already exists, the previous object is overwritten
  def add_param(obj)
    classname = obj.class.name
    if @config_param_types.include?(classname)
      delete_by_classname(classname)
    end
    @config_param_types << classname
    @config_params << obj
  end
  
  def <<(obj)
    self.add_param(obj)
  end
  
  def delete_by_classname(string)
    existing_object = find_by_classname(string)
    @config_params.delete(existing_object)
    @config_param_types.delete(string)
  end
  
  def find_by_classname(string)
    @config_params.each do |obj|
      if obj.class.name == string
        return obj
      else
        return nil
      end
    end
  end
  
  def delete_param(obj)
    if @config_params.include?(obj)
      @config_param_types.delete(obj.class.name)
      @config_params.delete(obj)
    end
  end
  
  #TODO Not right
  def create_plane
    new_plane = Plane.new
    new_plane.airline_id = need(id)
    new_plane.aircrafttype_id = need(aircrafttype.id)
    new_plane.starting_airport_code = need(airport.code)
    
    new_plane.avg_pax_load = aircrafttype.avg_pax_load_default
    new_plane.avg_speed = aircrafttype.avg_speed_default
    new_plane.range = aircrafttype.range_default 
    return new_plane
  end
  
end


# A class that allows the user to manage passenger counts easily
class StartingPaxCount < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def starting_pax_count
    @quantity
  end
  
  # Sets the value for '@quantity'
  def starting_pax_count=(input)
    @quantity=input
  end
end


# A class that allows the user to manage passenger counts easily
class StartingMilesCount < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def starting_miles_count
    @quantity
  end
  
  # Sets the value for '@quantity'
  def starting_miles_count=(input)
    @quantity=input
  end
end
