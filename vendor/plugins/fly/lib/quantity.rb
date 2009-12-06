# A class that allows the user to manage quantities easily
class Quantity
  
  attr_accessor :quantity
  attr_reader :type
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Takes a value identifying the quantity to capture; zero is assumed if no argument is
  # provided
  def initialize(value=0)
    @quantity = value
    @type = nil
  end
  
  # Increases the quantity object by the input amount; raises error if input is not numeric
  def increase(input)
    result = apply_math_operator("+", input)
    @quantity = result
    return self
  end
  
  # Decreases the quantity object by the input amount; raises error if input is non-numeric
  def decrease(input)
    result = apply_math_operator("-", input)
    @quantity = result
    return self
  end
  
  # Returns a new object of the same class as the first operand; sets quantity to the sum
  # of the two operands
  def +(input)
    result = apply_math_operator("+", input)
    return self.class.new(result)
  end
  
  # Returns a new object of the same class as the first operand; sets quantity to the difference
  # of the two operands
  def -(input)
    result = apply_math_operator("-", input)
    return self.class.new(result)
  end
  
  def apply_math_operator(operator_as_string, input)
    original_number = self.quantity
    if input.is_a?(Numeric)
      original_number.send(operator_as_string,input)
    elsif input.instance_variable_defined?("@quantity")
      original_number.send(operator_as_string,input.quantity)
    else
      raise TypeError.new("Argument is not valid")
    end
  end
end

# Class inherits from "Quantity" superclass
class QuantityOfPassengers < Quantity
  
  # Takes a value identifying the quantity to capture; zero is assumed if no argument is
  # provided.  Sets @type as "passengers".
  def initialize(value=0)
    @quantity = value
    @type = "passengers"
  end
end