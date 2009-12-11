class QueryParam
  
  attr_accessor :value, :type
  attr_reader :key
  
  def initialize(key,value=nil,type=nil)
    @key = key
    @value = value
    @type = type
  end
  
  
end