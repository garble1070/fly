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
  
  named_scope :code_is , lambda{|code| { :conditions => {:code => code}
    }}
  
  validates_presence_of  :user_id
  
  
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Try to find an object using the code; if not, pass on to ActiveRecord::Base
    def method_missing(name, *args)
      item = get_item_from_code(name)
      if item
        item
      else
        super(name,*args)
      end
    end
    
    # Retrieve the object using the code. 
    def get_item_from_code(symbol)
      results = self.code_is(symbol.to_s)
      results.first
    end
    
  end
  
  
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
    if item.charge_cost_to_my_account && item.save 
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
    flights = self.flights.active.in_order_of_creation
    flights.collect do |flight_obj|
      flight_obj.update_status_and_location
    end
  end
  
  # Returns an array of this airline's flight objects that are completed
  def completed_flights
    self.flights.completed.in_order_of_creation
  end
  
  # Returns an array of this airline's flight objects
  def all_flights
    self.flights.in_order_of_creation 
  end
  
  # Returns an array of this airline's plane objects, updated with status and location
  def all_planes
    self.planes.collect do |plane_obj|
      plane_obj.update_status_and_location
    end
  end
  
  # Returns the account that is ultimately responsible for this airline.
  def my_account
    self.user.my_account
  end
  
  # Reduces the satisfaction rating by the amount provided in the argument.  If the rating
  # would drop below zero, the transaction is canceled and the method returns false
  def satisfaction_rating_decrease(amount)
    if balance_adequate_for_transaction?(amount)
      self.satisfaction_rating = satisfaction_rating - amount
      record_transaction
    else
      return false
    end
  end
  
  # Increases the satisfaction rating by the amount provided in the argument.
  def satisfaction_rating_increase(amount)
    self.satisfaction_rating = satisfaction_rating + amount
    record_transaction
  end
  
  # Checks to see if the balance is adequate; returns "true" or "false"
  def balance_adequate_for_transaction?(amount)
    if self.satisfaction_rating > amount
      return true
    else
      return false
    end
  end
  
  # Saves the airline object; returns "true" if the save is successful
  def record_transaction
    if self.save
      return true
    else
      return false
    end   
  end
  
  # Returns the total quantity of <some quantity class> transported by this airline for 
  # all flights that exist
  def get_tally_by_flight_column_name(column_name)
    output = 0
    all_flights.each do |flight_obj|
      output += flight_obj.send(column_name)
    end
    return output
  end
  
  # Returns the total number of flights flown by this airline
  def flight_segment_tally
    all_flights.length
  end
  
  # Returns the total number of passengers flown by this airline
  def pax_count_tally
    get_tally_by_flight_column_name("pax_count")
  end  
  
  # Returns the total number of miles flown by this airline
  def flight_miles_tally
    get_tally_by_flight_column_name("flight_miles")
  end  
  
end
