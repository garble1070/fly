# Used to create a plane using configuration objects
class PlaneCreator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Constructor; accepts optional array of config params
  def initialize(param_array=[])
    set_expected_param_types
    @config_params = {}
    param_array.each do |obj|
      insert_param_using_object(obj)
    end
  end
  
  # Sets the instance variables '@required_param_types' and '@optional_param_types'
  def set_expected_param_types
    @required_param_types = ["Aircrafttype","Airline","Airport"]
    @optional_param_types = ["Name","StartingPaxCount","StartingMilesCount"]
  end
  
  # Stores the object in the '@config_params' hash
  def insert_param_using_object(obj)
    key = generate_key_from_object(obj)
    @config_params[key] = obj
  end
  
  # Returns a de-camelized string representing the object's class name
  def generate_key_from_object(obj)
    obj.class.name.underscore.to_sym
  end
  
  # Adds individual objects to the '@config_params' array; if one of that type
  # already exists, the previous object is overwritten
  def add_param(obj)
    insert_param_using_object(obj)
    return self
  end
  
  # Alias for 'add_param'
  def <<(obj)
    self.add_param(obj)
  end
  
  # If present, deletes a param object using a string that represents that param's class name.
  def delete_by_classname(string)
    key = string.underscore.to_sym
    @config_params.delete(key)
  end
  
  # Finds a param object using a string that represents that param's class name.
  def find_by_classname(string)
    key = string.underscore.to_sym
    if @config_params.key?(key)
      @config_params.fetch(key)
    end
  end
  
  # If present, deletes a specified object from the param list.
  def delete_param(obj)
    key = generate_key_from_object(obj)
    @config_params.delete(key)
  end
  
  # Tests to see whether or not an object is present in the param list
  def param_present?(obj)
    @config_params.value?(obj)
  end
  
  # Tests to see whether or not a string is present in the param classname list
  def param_classname_present?(string)
    key = string.underscore.to_sym
    @config_params.key?(key)
  end
  
  # Generates and returns a new item based on params previously provided, or raises
  # an exception if required params are not available
  def manufacture_item
    if required_param_types_present?
      generate_new_item_object
    else
      raise RuntimeError.new("One or more required objects is missing.")
    end
  end
  
  # Tests to see if all required param types are present 
  def required_param_types_present?
    results_array = @required_param_types.collect do |string|
      param_classname_present?(string)
    end
    unless results_array.include?(false)
      return true
    end
    return false
  end
  
  # Instantiates a new item object instance
  def generate_new_item_object
    new_item = Plane.new
    
    
    return new_item
=begin
    new_item.airline_id = need(id)
    new_item.aircrafttype_id = need(aircrafttype.id)
    new_item.starting_airport_code = need(airport.code)
    
    new_item.avg_pax_load = aircrafttype.avg_pax_load_default
    new_item.avg_speed = aircrafttype.avg_speed_default
    new_item.range = aircrafttype.range_default 
=end
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
