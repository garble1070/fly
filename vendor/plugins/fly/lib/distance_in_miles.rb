# A class that allows the user to manage distances easily
class DistanceInMiles < Quantity
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def distance_in_miles
    @quantity
  end
  
  # Sets the value for '@quantity'
  def distance_in_miles=(input)
    @quantity=input
  end
end
