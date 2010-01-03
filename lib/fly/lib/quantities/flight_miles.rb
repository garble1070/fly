# A class that allows the user to manage flight mile quantities easily
class FlightMiles < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def flight_miles
    @quantity
  end
  
  # Sets the value for '@quantity'
  def flight_miles=(input)
    @quantity=input
  end
end
