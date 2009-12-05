# A class that allows you to manage time durations easily
class Duration
  
  # Takes a value and an optional symbol identifying the time duration to capture
  def initialize(value,symbol=:secs)
    @duration = 0.0
    if (symbol == :hours) || (symbol == :hrs)
      @duration = value*60*60
    elsif (symbol == :minutes) || (symbol == :mins)
      @duration = value*60      
    elsif (symbol == :seconds) || (symbol == :secs)
      @duration = value
    else
      raise ArgumentError.new("Argument 2 is not a valid duration type")
    end
  end
  
  # Ouputs the stored duration in seconds
  def in_seconds
    @duration
  end
  
  # Alias for "in_seconds"
  def in_secs
    in_seconds
  end
  
  # Ouputs the stored duration in minutes
  def in_minutes
    @duration.quo(60)
  end
  
  # Alias for "in_minutes"
  def in_mins
    in_minutes
  end
  
  # Ouputs the stored duration in hours
  def in_hours
    @duration.quo(3600)
  end
  
  # Alias for "in_hours"
  def in_hrs
    in_hours
  end  

  # Placeholder method to be overridden in subclasses; raises an exception if called 
  # from the parent class
  def output
    raise RuntimeError.new("This method is meant to be called from duration subclasses,
           i.e. 'Seconds', 'Minutes', or 'Hours'")
  end
end

# A subclass that allows you to manage time durations from the perspective of seconds
class Seconds < Duration
  
  # Takes a value in seconds and captures that time duration
  def initialize(secs)
    @duration = secs
  end

  # Returns a value in seconds
  def output
    @duration
  end
end

# A subclass that allows you to manage time durations from the perspective of minutes
class Minutes < Duration

  # Takes a value in minutes and captures that time duration
  def initialize(mins)
    @duration = mins*60
  end
  
  # Returns a value in minutes
  def output
    @duration.quo(60)
  end
end

# A subclass that allows you to manage time durations from the perspective of hours
class Hours < Duration

  # Takes a value in hours and captures that time duration
  def initialize(hours)
    @duration = hours*60*60
  end

  # Returns a value in hours
  def output
    @duration.quo(3600)
  end
end