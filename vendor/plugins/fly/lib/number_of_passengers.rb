# A class that allows the user to manage passenger counts easily
class NumberOfPassengers < Quantity
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def number_of_passengers
    @quantity
  end
  
  # Sets the value for '@quantity'
  def number_of_passengers=(input)
    @quantity=input
  end
end

