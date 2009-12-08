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

# A class that allows the user to manage durations easily
class DurationInSeconds < Quantity
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def duration_in_seconds
    @quantity
  end
  
  # Sets the value for '@quantity'
  def duration_in_seconds=(input)
    @quantity=input
  end
    
  # Outputs the stored duration in minutes
  def duration_in_minutes
    @quantity.quo(60)
  end
    
  # Outputs the stored duration in hours
  def duration_in_hours
    @quantity.quo(3600)
  end

end

# A class that allows the user to manage boarding durations easily
class BoardingDurationInSeconds < DurationInSeconds
end

# A class that allows the user to manage taxi durations easily
class TaxiDurationInSeconds < DurationInSeconds
end

# A class that allows the user to manage inflight durations easily
class InflightDurationInSeconds < DurationInSeconds
end

# A class that allows the user to manage maintenance durations easily
class MaintenanceDurationInSeconds < DurationInSeconds
end

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
