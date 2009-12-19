# A class that allows the user to manage distances easily
class DistanceInMiles < Quantity
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  

  # Returns the value from '@quantity'
  def in_miles
    @quantity
  end
  
  # Sets the value for '@quantity'
  def in_miles=(input)
    @quantity=input
  end

  # Returns the value from '@quantity'
  def in_nautical_miles
    @quantity * MILE_IN_NAUTICAL_MILES
  end
  
  # Sets the value for '@quantity'
  def in_nautical_miles=(input)
    @quantity = input * NAUTICAL_MILE_IN_MILES
  end
end
