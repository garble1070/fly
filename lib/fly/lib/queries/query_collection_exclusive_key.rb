# A version of the QueryCollection class that does not allow for multiple query parameters with the
# same keyname
class QueryCollectionExclusiveKey < QueryCollection
  
  # Adds a parameter to the @collection. If a QueryParam already exists with the same key,
  # overwrites its value and type.  Returns the (new) QueryParam object.
  def add_param(key,value=nil,type=nil)
    obj = find(key)
    if obj
      obj.value = value
    end
    if obj && type
      obj.type = type
    end
    unless obj
      obj = QueryParam.new(key,value,type)
      @collection << obj
      @count +=1
    end
    return obj
  end
  
  # Walks the @collection and returns the object that matches the key provided
  def find(key)
    @collection.each do |obj|
      if obj.key == key
        return obj
      end
    end  
    return nil
  end
  
  # If an object exists in the @collection that matches the key provided, deletes it.
  def delete_param(key)
    obj = find(key)
    if obj
      @count -=1
      @collection.delete(obj)
    end
  end
  
  # Copies the QueryCollection, then deletes a parameter from the new instance.
  def copy_and_delete_param(key)
    new = self.copy
    new.delete_param(key)
    return new
  end
  
  # Toggles the value of "zero" or "binary" type params
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
  
  # Toggles the value of a "zero" type param
  def toggle_param_zero(obj)
    if obj.value.to_s == "0"
      obj.value = nil
    else
      obj.value = "0"
    end
    return obj
  end
  
  # Toggles the value of a "binary" type param
  def toggle_param_binary(obj)
    if obj.value.to_s == "1"
      obj.value = nil
    else
      obj.value = "1"
    end
    return obj
  end
  
  # Returns a value based on the missing method as keyname, or nil if no relevant object
  # can be found.
  def method_missing(name, *args)
    obj = find(name.to_s)
    if obj
      return obj.value
    else
      return nil
    end
  end
  
end
