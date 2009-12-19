# A class allowing the user to easily manage query url creation.
class QueryCollection
  
  attr_reader :collection
  attr_reader :count
  
  # Constructor. Defines null values for the '@collection' and '@count' instance variables.
  def initialize()
    @collection = []
    @count = 0
  end
  
  # Returns a new QueryCollection instance, made up of identical key/value pairings but using
  # different QueryParam objects.  This is important so that changes to the new QueryCollection
  # are not mirrored in the old instance.
  def copy
    copy = self.clone
    copy.delete_all
    @collection.each do |obj|
      copy.add_param(obj.key,obj.value,obj.type)
    end
    return copy
  end
  
  # Copies the QueryCollection, then adds a new parameter to the new instance.
  def copy_and_add_param(key,value=nil,type=nil)
    new = self.copy
    new.add_param(key,value,type)
    return new
  end
  
  # Deletes all objects in the '@collection' and sets the @count to zero.
  def delete_all
    @count = 0
    @collection = []
  end
  
  # Returns a query URL string
  def output
    output_str = "?"
    @collection.each do |obj|
      if obj.value && obj.value.is_a?(Hash)
        key = "#{obj.key}[#{obj.value.to_a[0][0]}]" 
        value = "#{obj.value.to_a[0][1]}"
      elsif obj.value
        key = obj.key
        value = obj.value
      end
      output_str << "#{key}=#{value}&"    
    end
    return output_str.chop
  end
  
  # Complains if the user calls the 'add_param' method from a instance of this abstract class.
  def add_param(key,value=nil,type=nil)
    FlyError::raise_superclass_error
  end
  
  # Complains if the user calls the 'find' method from a instance of this abstract class.
  def find(key)
    FlyError::raise_superclass_error
  end
    
end