class QueryCollection
  
  attr_reader :collection
  attr_reader :count
  
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
    obj = QueryParam.new(key,value,type)
    @collection << obj
    @count +=1
    return obj
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
  
  def method_missing(name, *args)
    obj = find(name.to_s)
    if obj
      return obj.value
    else
      return nil
    end
  end
  
  def output
    output_str = "?"
    output_hash = {}
    @collection.each do |obj|
      output_str << "#{obj.key}=#{obj.value}&"    
    end
    return output_str.chop
  end
  
end

