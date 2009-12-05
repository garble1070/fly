  class Duration
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
    
    def in_seconds
      @duration
    end
    
    def in_secs
      in_seconds
    end
    
    def in_minutes
      @duration.quo(60)
    end
    
    def in_mins
      in_minutes
    end
    
    def in_hours
      @duration.quo(3600)
    end
    
    def in_hrs
      in_hours
    end  
  end
  
  class Seconds < Duration
    def initialize(secs)
      @duration = secs
    end
  end
  
  class Minutes < Duration
    def initialize(mins)
      @duration = mins*60
    end
  end
  
  class Hours < Duration
    def initialize(hours)
      @duration = hours*60*60
    end
  end