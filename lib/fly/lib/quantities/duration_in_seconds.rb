# A class that allows the user to manage durations easily
class DurationInSeconds < Quantity
  
  #**********************************************#
  #         CLASS INSTANCE METHODS               #
  #**********************************************#  
  
class << self
  def new_in_minutes(value)
    self.new(value*60) 
  end
  
  def new_in_hours(value)
    self.new(value*3600)
  end
end

  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def in_seconds
    @quantity
  end
  
  # Sets the value for '@quantity'
  def in_seconds=(input)
    @quantity=input
  end
    
  # Outputs the stored duration in minutes
  def in_minutes
    @quantity.quo(60)
  end
    
  # Outputs the stored duration in hours
  def in_hours
    @quantity.quo(3600)
  end

end

# A class that allows the user to manage boarding durations easily
class BoardingDurationInSeconds < DurationInSeconds
end

# A class that allows the user to manage taxi durations easily
class TaxiDurationInSeconds < DurationInSeconds
end

=begin
# A class that allows the user to manage inflight durations easily
class InflightDurationInSeconds < DurationInSeconds
end
=end

# A class that allows the user to manage maintenance durations easily
class MaintenanceDurationInSeconds < DurationInSeconds
end