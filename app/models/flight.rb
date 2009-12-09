# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  belongs_to :plane
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns the airport object for the departure airport on this route
  def dep_airport
    Airport.find(self.dep_airport_code)
  end
  
  # Returns the airport object for the arrival airport on this route
  def arr_airport
    Airport.find(self.arr_airport_code)
  end

  
end
