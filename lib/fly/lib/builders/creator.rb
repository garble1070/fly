# Used to create an item using configuration objects
class Creator
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Constructor; accepts optional array of config param objects
  def initialize(param_array=[])
    set_required_param_types
    set_optional_param_types
    @config_params = {}
    param_array.each do |obj|
      insert_param_using_object(obj)
    end
    return self
  end
  
  # Sets the instance variable '@required_param_types'.  Meant to be overwritten
  # in the subclass
  def set_required_param_types
    @required_param_types = []
  end
  
  # Sets the instance variable '@optional_param_types'.  Meant to be overwritten
  # in the subclass
  def set_optional_param_types
    @optional_param_types = []
  end
  
  # Returns the param using its 'lowercase_' name as a method call
  def method_missing(name, *args)
    param_name = name.to_s.camelize
    if @optional_param_types.include?(param_name)
      param_by_classname(param_name)
    end
  end
  
  # Inserts optional params into new item object
  def insert_optional_params_into_new_item_object(subclass_object)
    @optional_param_types.each do |param_name|
      method_name = "insert_param_based_on_"
      method_name << get_penultimate_superclass_from_camlized_string(param_name).underscore
      subclass_object.send(method_name,param_name.underscore)
    end
  end
  
  #
  def get_penultimate_superclass_from_camlized_string(param_name)
    superclass = Module.const_get(param_name)
    while superclass.name != "Object"
      penultiamte_class = superclass
      superclass = superclass.superclass
    end
    return penultiamte_class
  end
  
  #
  def insert_param_based_on_string(param_name)
    setter_method = param_name + "="
    if send(param_name)
      @new_item.send(setter_method,send(param_name).to_s)
    end
  end
  
  #
  def insert_param_based_on_quantity(param_name)
    setter_method = param_name + "="
    if send(param_name)
      @new_item.send(setter_method,send(param_name).quantity)
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
  
  
end

