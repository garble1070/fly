# Each entry represents an individual aircraft in service
class Plane < ActiveRecord::Base
  belongs_to :airline
  belongs_to :aircrafttype
  has_many :flights
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns an airport object that represents this plane's starting location
  def starting_airport_obj
    Airport.find(self.starting_airport_code)
  end
  
  # Alias for 'starting_airport_obj', to match rails convention
  def starting_airport
    self.starting_airport_obj
  end

  # Returns this plane's aircrafttype object
  def aircrafttype_obj
    self.aircrafttype
  end

  # Returns this plane's airline object
  def airline_obj
    self.airline
  end
  
  # Creats a new Flight object, saves it to the database. Returns the object if save is 
  # successful.
  def trigger_new_flight(param_array)
    param_array << self
    new_flight = FlightCreator.new(param_array).manufacture
    return new_flight.save ? new_plane : nil
  end
  
end

