# A class that allows the user to manage payload value easily
class PayloadValueFlc < Quantity
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def payload_value_flc
    @quantity
  end
  
  # Sets the value for '@quantity'
  def payload_value_flc=(input)
    @quantity=input
  end
end

