# An airline, can be only owned by one user at a time.
class Airline < ActiveRecord::Base
  belongs_to :user
  belongs_to :country, :foreign_key => "country_code"
  has_many :planes
  has_many :terminals
  has_many :flights, :through => :planes
  has_many :aircrafttypes, :through => :planes
  
  has_one :home_airport_game, 
      :class_name => "Airport",
      :foreign_key => "code",
      :primary_key => "home_airport_code_game"
  
  named_scope :ops_airport_is, lambda{|airport| {
    :select=>"`airlines`.*",
    :joins=>"INNER JOIN `terminals` on `airlines`.id = `terminals`.airline_id",
    :conditions=>["`terminals`.airport_code = ?", airport.code]
    }}
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Creats a new Plane, using an aircrafttype object as an argument
  def acquire_new_plane(aircrafttype)
    home_airport = self.home_airport_game
    param_array = [aircrafttype,self,home_airport]
    new_plane = PlaneCreator.new(param_array).manufacture
    finalize_acquisition_and_save(new_plane)
  end
  
  # Finalizes the acquistion (plane or terminal) by charging the value of the item to the user's 
  # account. If charge goes through, and if the new plane record saves into the database, returns 
  # the updated item object. Otherwise, returns nil.
  def finalize_acquisition_and_save(item)
    if item.charge_cost_to_owners_account && item.save 
      return item
    else
      return nil
    end
  end
  
  # Lists all airports where the Airline has terminals
  def ops_airports
    Airport.ops_airline_is(self)
  end
  
  # Creates a new Terminal, using an airport object as an argument
  def acquire_new_terminal(airport)
    unless self.ops_airports.include?(airport)
      terminal = Terminal.new(:airport_code => airport.code, :airline_id => self.id)
      terminal.boarding_gate_cost_new = airport.boarding_gate_cost_new_default
      terminal.boarding_gate_count = 1
      finalize_acquisition_and_save(terminal)
    end
  end
  
  # Returns an array of this airline's flight objects that are active, i.e. 
  # do not have the status "completed"
  def active_flights
    self.flights.active.in_order_of_creation
  end
  
  # Returns an array of this airline's flight objects that are completed
  def completed_flights
    self.flights.completed.in_order_of_creation
  end
  
  # Returns an array of this airline's flight objects
  def all_flights
    self.flights.in_order_of_creation 
  end
  
  
  def satisfaction_rating_decrease(amount)
    if balance_adequate_for_transaction?(amount)
      self.satisfaction_rating = satisfaction_rating - amount
      record_transaction
    else
      return false
    end
  end
   
  def satisfaction_rating_increase(amount)
    self.satisfaction_rating = satisfaction_rating + amount
    record_transaction
  end
  
  def balance_adequate_for_transaction?(amount)
    if self.satisfaction_rating > amount
      return true
    else
      return false
    end
  end
  
  def record_transaction
    if self.save
      return true
    else
      return false
    end   
  end
  
end
