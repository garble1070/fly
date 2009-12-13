# A class allowing the user to easily manage query url creation.
class QueryCollection
  
  attr_reader :collection
  attr_reader :count
  
  # Constructor. 
  def initialize()
    @collection = []
    @count = 0
  end
  
  def copy
    copy = self.clone
    copy.delete_all
    @collection.each do |obj|
      copy.add_param(obj.key,obj.value,obj.type)
    end
    return copy
  end
  
  def add_param(key,value=nil,type=nil)
    obj = find(key)
    if obj
      obj.value = value
      if type
        obj.type = type
      end
      return obj
    else
      obj = Views::KM::QueryParam.new(key,value,type)
      @collection << obj
      @count +=1
      return obj
    end
  end
  
  def copy_and_add_param(key,value=nil,type=nil)
    new = self.copy
    new.add_param(key,value,type)
    return new
  end
  
  def copy_and_delete_param(key)
    new = self.copy
    new.delete_param(key)
    return new
  end
  
  def find(key)
    @collection.each do |obj|
      if obj.key == key
        return obj
      end
    end  
    return nil
  end
  
  def delete_param(key)
    obj = find(key)
    if obj
      @count -=1
      @collection.delete(obj)
    end
  end
  
  def delete_all
    @count = 0
    @collection = []
  end
  
  def toggle_param(key)
    obj = find(key)
    if obj && obj.type && obj.type == :zero
      toggle_param_zero(obj)    
    elsif obj && obj.type && obj.type == :binary
      toggle_param_binary(obj)
    else
      return nil
    end
  end
  
  def toggle_param_zero(obj)
    if obj.value.to_s == "0"
      obj.value = nil
    else
      obj.value = "0"
    end
    return obj
  end
  
  def toggle_param_binary(obj)
    if obj.value.to_s == "1"
      obj.value = nil
    else
      obj.value = "1"
    end
    return obj
  end
  
  def method_missing(name, *args)
    obj = find(name.to_s)
    if obj
      return obj.value
    else
      return nil
    end
  end
  
  def output
    prep_output_hash
    @output_hash.each do |key,value|
      output_str << "#{key}=#{value}&"    
    end
    return output_str.chop
  end
  
  def prep_output_hash
    output_str = "?"
    @output_hash = {}
    @collection.each do |obj|
      if obj.value && obj.value.is_a?(Hash)
        @output_hash["#{obj.key}[#{obj.value.to_a[0][0]}]"] = "#{obj.value.to_a[0][1]}"
      elsif obj.value
        @output_hash["#{obj.key}"] = "#{obj.value}"
      end
    end
  end
  
end

# A version of the QueryCollection class that allows for multiple query parameters with the
# same keyname
class QueryCollectionNonExclusiveKey < QueryCollection
  
  # Overrides the parent method to allow for multiple query parameters with the same keyname
  def add_param(key,value=nil,type=nil)
    obj = QueryParam.new(key,value,type)
    @collection << obj
    @count +=1
    return obj
  end
  
  # Returns an array of one or more objects based on the keyname, or an empty
  # array if none can be found.
  def find(key)
    response = []
    @collection.each do |obj|
      if obj.key == key
        response << obj
      end
    end  
    return response
  end
  
  # Returns an array of one or more values based on the missing method as keyname, or an empty
  # array if none can be found.
  def method_missing(name, *args)
    response = []
    obj_array = find(name.to_s)
    obj_array.each do |obj|
      response << obj.value
    end
    return response
  end
  
  # Overrides the parent method, because it is not meaningful in the context of non-
  # exclusive keynames.
  def delete_param(key)
  end
  
  # Overrides the parent method, because it is not meaningful in the context of non-
  # exclusive keynames.
  def toggle_param(key)
  end
  
  # Overrides the parent method, because it is not meaningful in the context of non-
  # exclusive keynames.
  def toggle_param_zero(obj)
  end
  
  # Overrides the parent method, because it is not meaningful in the context of non-
  # exclusive keynames.
  def toggle_param_binary(obj)
  end
  
  
end

