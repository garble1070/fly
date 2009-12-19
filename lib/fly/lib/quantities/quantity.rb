# A class that allows the user to manage quantities easily.
class Quantity
    
  attr_accessor :quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
    
  # Takes a value identifying the quantity to capture; zero is assumed if no argument is
  # provided
  def initialize(value=0)
    @quantity = value
  end
  
  # Increases the quantity object by the input amount; returns original object
  def increase(input)
    @quantity = apply_math_operator("+", input)
    return self
  end
  
  # Decreases the quantity object by the input amount; returns original object
  def decrease(input)
    @quantity = apply_math_operator("-", input)
    return self
  end
  
  # Returns a new object of the same class as the first operand; sets quantity to the sum
  # of the two operands
  def +(input)
    result = apply_math_operator("+", input)
    return self.class.new(result)
  end
  
  # Returns a new object of the same class as the first operand; sets quantity to the 
  # difference between the two operands
  def -(input)
    result = apply_math_operator("-", input)
    return self.class.new(result)
  end
  
  # Applies an operator (passed as a string in the first argument) to create a mathematical 
  # expression using the '@quantity' variable as the source operand and the 2nd 
  # argument as the target operand.  Works when the latter argument is numeric OR if it has 
  # a '@quantity' instance variable.
  def apply_math_operator(operator_as_string, target)
    original_number = self.quantity
    has_instance_variable = target.instance_variable_defined?("@quantity")
    target_number = has_instance_variable ? target.quantity : target
    original_number.send(operator_as_string,target_number)
  end
end
