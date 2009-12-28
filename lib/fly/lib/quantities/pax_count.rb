# A class that allows the user to manage passenger counts easily
class PaxCount < Quantity
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def pax_count
    @quantity
  end
  
  # Sets the value for '@quantity'
  def pax_count=(input)
    @quantity=input
  end
end

