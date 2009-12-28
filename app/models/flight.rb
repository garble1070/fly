# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  
  belongs_to :plane
  
  belongs_to :dep_airport, 
      :class_name => "Airport", 
      :primary_key => "code",
      :foreign_key => "dep_airport_code"
  
  belongs_to :arr_airport, 
      :class_name => "Airport", 
      :primary_key => "code",
      :foreign_key => "arr_airport_code"
  
  named_scope :user_is, lambda{|user| {
    :select=>"`flights`.*",
    :joins=>"INNER JOIN `planes` on `planes`.id = `flights`.plane_id 
             INNER JOIN `airlines` ON `planes`.airline_id = `airlines`.id",
    :conditions=>["`airlines`.user_id = ?", user.id]
    }}
  
  named_scope :plane_is, lambda{|plane_id| {
    :conditions=>["plane_id = ?", plane_id]
    }}
  
  named_scope :ops_airport_is, lambda{|airport| {
    :select=>"`airlines`.*",
    :joins=>"INNER JOIN `terminals` on `airlines`.id = `terminals`.airline_id",
    :conditions=>["`terminals`.airport_code = ?", airport.code]
    }}
  
  named_scope :completed, :conditions=>["flight_completed_time IS NOT NULL"]
  named_scope :active, :conditions=>["flight_completed_time IS NULL"]
  named_scope :in_order_of_creation, :order=>"created_at ASC"
  
  attr_reader :status_snapshot, :status_snapshot_time
  attr_reader :location_snapshot, :location_snapshot_time
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Updates the current status and stores it in the "@status_snapshot" instance
  # variable, as well as the current time in the "@status_snapshot"time" variable
  def update_status
    @status_snapshot = current_status
    @status_snapshot_time = Time.now
    return self
  end
  
  # Returns a symbol representing the flight's current status
  def current_status
    case
      when flight_completed_time then :completed
      when !boarding_start_time then :assigned_to_route
      when time_since_takeoff >= inflight_duration then :arrived
      when time_since_taxi_start >= taxi_duration then :in_flight
      when time_since_boarding_start >= boarding_duration then :departed_gate
      when Time.new >= boarding_start_time then :boarding
    else
    :scheduled
    end
  end
  
  # Returns an integer representing the duration since the flight began boarding
  def time_since_boarding_start
   (Time.new - boarding_start_time).to_int
  end
  
  # Returns an integer representing the duration since the flight began taxiing
  def time_since_taxi_start
   (Time.new - boarding_start_time - boarding_duration).to_int
  end
  
  # Returns an integer representing the duration since the flight took off
  def time_since_takeoff
   (Time.new - boarding_start_time - boarding_duration - taxi_duration).to_int
  end
  
  # Updates the current status and stores it in the "@status_snapshot" instance
  # variable, as well as the current time in the "@status_snapshot"time" variable
  def update_location
    @location_snapshot = current_location
    @location_snapshot_time = Time.now
    return self
  end
  
  # Returns a flight object with updated status and location instance variables
  def update_status_and_location
    update_status.update_location
  end
  
  # Returns an object that includes "@lat" and "@lng" variables
  def current_location
    case
      when flight_completed_time then arr_airport
      when !boarding_start_time then dep_airport
      when time_since_takeoff >= inflight_duration then arr_airport
      when time_since_taxi_start >= taxi_duration then inflight_position
      when time_since_boarding_start >= boarding_duration then dep_airport.latlng
      when Time.new >= boarding_start_time then dep_airport
    else
      dep_airport
    end
  end
    
  # Returns a LatLng object representing the flight's current position in-flight.
  def inflight_position
    flight_distance = DistanceInMiles.new
    flight_distance.in_nautical_miles = time_since_takeoff.quo(3600) * plane.avg_speed_knots
    flight_distance = distance_capped_at_route_length(flight_distance)
    heading = dep_airport.heading_to(arr_airport)
    return dep_airport.endpoint(heading,flight_distance.in_miles)
  end
  
  # Returns a flight distance that is no longer than the total route length of the 
  # flight
  def distance_capped_at_route_length(flight_distance)
    if flight_distance.in_miles > dep_airport.distance_from(arr_airport)
      flight_distance.in_miles = dep_airport.distance_from(arr_airport)
    end
    return flight_distance
  end
  
  
end
