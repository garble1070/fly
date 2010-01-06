# Each entry represents an individual aircraft in service
class Plane < ActiveRecord::Base
  belongs_to :airline
  belongs_to :aircrafttype
  has_many :flights
  has_one :starting_airport, 
      :class_name => "Airport", 
      :foreign_key => "code",
      :primary_key => "starting_airport_code"
  
  attr_reader :status_snapshot, :status_snapshot_time
  attr_reader :location_snapshot, :location_snapshot_time
    
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  
  # Creats a new Flight object, saves it to the database. Returns the object if save is 
  # successful.
  def trigger_new_flight(dep_airport_obj, arr_airport_obj)
    param_array = generate_param_array_from_airport_objects(dep_airport_obj, arr_airport_obj)
    new_flight = FlightCreator.new(param_array).manufacture
    return new_flight.save ? new_flight : nil
  end
  
  # Returns an array of parameters that can be used to manufacture a new flight object
  def generate_param_array_from_airport_objects(dep_airport_obj, arr_airport_obj)
    param_array = [self]
    param_array << DepartureAirport.send(dep_airport_obj.code)
    param_array << ArrivalAirport.send(arr_airport_obj.code)
    return param_array
  end
  
  # Returns the account that is ultimately responsible for this plane.
  def my_account
    self.airline.user.my_account
  end
  
  # Charges the cost of this aircrafttype to the plane's (new) owner.
  def charge_cost_to_my_account
    self.my_account.debit(self.aircrafttype.cost)
  end
  
  # Updates the current status and stores it in the "@status_snapshot" instance
  # variable, as well as the current time in the "@status_snapshot"time" variable
  def update_status
    @status_snapshot = current_status
    @status_snapshot_time = Time.now
    return self
  end
  
  # Updates the "@location_snapshot" and "@location_snapshot_time" instance variables
  # and returns itself (i.e. the plane object)
  def update_location
    @location_snapshot = current_location
    @location_snapshot_time = Time.now
    return self
  end
  
  # Updates all status and location instance variables and returns itself (i.e. 
  # the plane object)
  def update_status_and_location
    update_status.update_location
  end
  
  # Returns a symbol representing the plane's current status
  def current_status
    my_flight = most_recent_flight
    if !my_flight || (my_flight.status_snapshot == :completed)
      :available                   
    else
      my_flight.status_snapshot                                                     
    end
  end
  
  # Returns a flight object that represents the plane's last flight. If no flight has ever
  # been created, returns nil.
  def most_recent_flight
    all_flights = Flight.plane_is(self).in_order_of_creation
    if all_flights.length > 0
      return all_flights.last.update_status_and_location
    else
      return nil
    end
  end
  
  # Returns an object that includes "@lat" and "@lng" variables
  def current_location
    my_flight = most_recent_flight
    if my_flight
      my_flight.current_location
    else
      self.airline.home_airport_game
    end
  end
  
  # Returns the total pax transported by this aircraft for all flights that exist
    def get_tally_by_column_name(column_name)
    output = 0
    flights.each do |flight_obj|
      output += flight_obj.send(column_name)
    end
    return output
  end
  
  # Returns the total number of flights flown by this aircraft
  def flight_segment_tally
    flights.length
  end
end