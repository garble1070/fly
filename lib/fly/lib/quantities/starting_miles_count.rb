# A class that allows the user to manage miles counts easily
class StartingMilesCount < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def starting_miles_count
    @quantity
  end
  
  # Sets the value for '@quantity'
  def starting_miles_count=(input)
    @quantity=input
  end
end
