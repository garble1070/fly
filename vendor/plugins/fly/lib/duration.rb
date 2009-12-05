# A class that allows you to manage time durations easily
class Duration

  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#

  class << self
    
    # Returns a new instance using an argument denominated in seconds
    def new_using_seconds(value_in_secs)
      self.new(value_in_secs,:seconds)
    end
    
    # Returns a new instance using an argument denominated in minutes
    def new_using_minutes(value_in_mins)
      self.new(value_in_mins,:minutes)
    end
    
    # Returns a new instance using an argument denominated in hours
    def new_using_hours(value_in_hrs)
      self.new(value_in_hrs,:hours)
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Takes a value and a symbol identifying the time duration to capture
  def initialize(value,symbol)
    case symbol 
      when :hours    then @duration = value*3600
      when :minutes  then @duration = value*60      
      when :seconds  then @duration = value
    else
      raise ArgumentError.new("Argument 2 is not a valid duration type")
    end
  end
  
  # Ouputs the stored duration in seconds
  def in_seconds
    @duration
  end
  
  # Ouputs the stored duration in minutes
  def in_minutes
    @duration.quo(60)
  end
    
  # Ouputs the stored duration in hours
  def in_hours
    @duration.quo(3600)
  end
  
end

