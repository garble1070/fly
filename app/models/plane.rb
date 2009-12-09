# Each entry represents an individual aircraft in service
class Plane < ActiveRecord::Base
  belongs_to :airline
  belongs_to :aircrafttype
  has_many :flights
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns an airport object that represents this plane's starting location
  def starting_airport
    Airport.find(self.starting_airport_code)
  end
    
  # Creats a new Flight object, saves it to the database. Returns the object if save is 
  # successful.
  def trigger_new_flight(param_array)
    param_array << self
    new_flight = FlightCreator.new(param_array).manufacture
    return new_flight.save ? new_plane : nil
  end
  
end

