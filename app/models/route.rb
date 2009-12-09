# A route that our airplanes are allowed to fly, with mileage. Includes the
# option to specify a route for all aircraft types or one at a time
class Route < ActiveRecord::Base
  has_many :flights
  
  named_scope :city_pair_is, lambda { |dep_code,arr_code| 
    {:conditions => { "dep_airport_code" => dep_code,
                           "arr_airport_code" => arr_code}}}
  
  named_scope :dep_airport_is, lambda { |dep_code|
    {:conditions => { "dep_airport_code" => dep_code}}}
  
  named_scope :arr_airport_is, lambda { |arr_code|
    {:conditions => { "arr_airport_code" => arr_code}}}
  

  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    def find (*args)
      if args[0].is_a?(Array)
        param_array = args[0]
        find_route_obj(param_array[0],param_array[1])
      else
        super(*args)
      end
    end

    # Returns the route obj based on 2 airport objects (departure, arrival)    
    def find_route_obj (dep_airport,arr_airport)
      if dep_airport.code == arr_airport.code
        raise ArgumentError.new("Departing and arriving airports are the same.")
      end      
      routes = Route.city_pair_is(dep_airport.code,arr_airport.code)
      if routes.length > 0
        routes[0]
      end
    end
    
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
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
