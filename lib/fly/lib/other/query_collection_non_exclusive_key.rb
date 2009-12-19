# A version of the QueryCollection class that allows for multiple query parameters with the
# same keyname
class QueryCollectionNonExclusiveKey < QueryCollection
  
  # Adds a new QueryParam object to the '@collection' array
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
  
end

