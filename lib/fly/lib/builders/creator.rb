# Used to create an item using configuration objects
class Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Constructor; accepts optional array of config param objects
  def initialize(param_array=[])
    set_expected_param_types
    @config_params = {}
    param_array.each do |obj|
      insert_param_using_object(obj)
    end
    return self
  end
  
  # Sets the instance variables '@required_param_types'.  Meant to be overwritten
  # in the subclass
  def set_expected_param_types
    @required_param_types = []
    @possible_param_types = []
  end
  
  # Returns the param using its 'lowercase_' name as a method call
  def method_missing(name, *args)
    param_name = name.to_s.camelize
    if @possible_param_types.include?(param_name)
      param_by_classname(param_name)
    else
      super(name,*args)
    end
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
  def param_by_classname(string)
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
  def manufacture
    if required_param_types_present?
      generate_new_item_object
    else
      raise RuntimeError.new("One or more required objects is missing.")
    end
  end
  
  # Tests to see if all required param types are present 
  def required_param_types_present?
    @required_param_types.each do |string|
      return false unless param_classname_present?(string)
    end
    return true
  end
  
  # Meant to be overridden
  def generate_new_item_object
    FlyError::raise_superclass_error
  end
  
  # Meant to be overridden
  def insert_required_params_into_new_item_object
    FlyError::raise_superclass_error
  end
  
  # Meant to be overridden
  def insert_optional_params_into_new_item_object
    FlyError::raise_superclass_error
  end
  
end

