# A class that allows the user to manage passenger counts easily
class StartingPaxCount < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def starting_pax_count
    @quantity
  end
  
  # Sets the value for '@quantity'
  def starting_pax_count=(input)
    @quantity=input
  end
end
