# A class that allows the user to manage durations easily
class DurationInSeconds < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def duration_in_seconds
    @quantity
  end
  
  # Sets the value for '@quantity'
  def duration_in_seconds=(input)
    @quantity=input
  end
    
  # Outputs the stored duration in minutes
  def duration_in_minutes
    @quantity.quo(60)
  end
    
  # Outputs the stored duration in hours
  def duration_in_hours
    @quantity.quo(3600)
  end

end
