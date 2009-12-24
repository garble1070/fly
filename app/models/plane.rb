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
    param_array << DepartureAirport.find(dep_airport_obj.code)
    param_array << ArrivalAirport.find(arr_airport_obj.code)
    return param_array
  end
  
  # Returns the account that is ultimately responsible for this plane.
  def owners_flc_account
    self.airline.user.my_flc_account
  end
  
  #Charges the cost of this aircrafttype to the plane's (new) owner.
  def charge_cost_to_owners_account
    self.owners_flc_account.debit(self.aircrafttype.cost)
  end
  
  # Updates the current status and stores it in the "@status_snapshot" instance
  # variable, as well as the current time in the "@status_snapshot"time" variable
  def update_status
    @status_snapshot = current_status
    @status_snapshot_time = Time.now
    return self
  end

  # 
  def update_location
    @location_snapshot = current_location
    @location_snapshot_time = Time.now
    return self
  end
  
  # 
  def update_status_and_location
    update_status.update_location
  end
  
  # Returns a symbol representing the plane's current status
  def current_status
    my_flight = most_recent_flight
    case
      when my_flight.flight_completed_time then :available
      when !my_flight.boarding_start_time then :assigned_to_route
      when my_flight.time_since_takeoff >= inflight_duration then :arrived
      when my_flight.time_since_taxi_start >= taxi_duration then :in_flight
      when my_flight.time_since_boarding_start >= boarding_duration then :departed_gate
      when Time.new >= my_flight.boarding_start_time then :boarding
    else
    :flight_scheduled
    end
  end
  
  #
  def most_recent_flight
    all_flights = Flight.plane_is(self.id).in_order_of_creation
    return all_flights.last
  end
  
  # Returns an object that includes "@lat" and "@lng" variables
  def current_location
    my_flight = most_recent_flight
    case
      when my_flight.flight_completed_time then my_flight.arr_airport
      when !my_flight.boarding_start_time then :assigned_to_route
      when my_flight.time_since_takeoff >= inflight_duration then :arrived
      when my_flight.time_since_taxi_start >= taxi_duration then :in_flight
      when my_flight.time_since_boarding_start >= boarding_duration then :departed_gate
      when Time.new >= my_flight.boarding_start_time then :boarding
    else
    :flight_scheduled
    end
  end
  
end