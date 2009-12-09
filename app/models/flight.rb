# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  belongs_to :plane
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns this flight's plane object
  def plane_obj
    self.plane
  end
  
  # Returns the airport object for the departure airport on this route
  def dep_airport_obj
    Airport.find(self.dep_airport_code)
  end
  
  # Alias for 'dep_airport_obj', to match rails convention
  def dep_airport
    self.dep_airport_obj
  end
  
  # Returns the airport object for the arrival airport on this route
  def arr_airport_obj
    Airport.find(self.arr_airport_code)
  end

  # Alias for 'arr_airport_obj', to match rails convention
  def arr_airport
    self.arr_airport_obj
  end

  
end
