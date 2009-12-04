# A route that our airplanes are allowed to fly, with mileage. Includes the
# option to specify a route for all aircraft types or one at a time
class Route < ActiveRecord::Base
  
  named_scope :city_pair_is, lambda { |dep_code,arr_code| 
    {:conditions => { "dep_airport_code" => dep_code,
                           "arr_airport_code" => arr_code}}}
  
  named_scope :aircrafttype_is, lambda { |type_id|
    {:conditions => { "aircrafttype_id" => type_id}}}
  
  class << self
    
    #**********************************************#
    #              CLASS ATTRIBUTES                #
    #**********************************************#
    
    # Returns the route obj based on 2 airport objects and an aircrafttype object
    
    def get (dep_airport,arr_airport,aircrafttype)
      arg_kind_of(Aircrafttype,aircrafttype)
      arg_kind_of(Airport,dep_airport)
      arg_kind_of(Airport,arr_airport)
      if dep_airport == arr_airport
        raise ArgumentError.new("Departing and arriving airports are the same.")
      end      

      aircrafttype_id = need(aircrafttype.id)
      dep_airport_code = need(dep_airport.code)
      arr_airport_code = need(arr_airport.code)
      routes = Route.city_pair_is(dep_airport_code,arr_airport_code)
      
      exact_route = routes.aircrafttype_is(aircrafttype_id)[0]
      generic_route = routes.aircrafttype_is(0)[0]
      
      if exact_route
        exact_route
      elsif generic_route
        generic_route
      else
        nil
      end  
    end
    
    #TODO:  break this out to activerecord base class
    # Returns a target object or raises an exception if nil
    def need(target)
      if target
        target
      else
        raise RuntimeError.new("Expecting object to be not nil.")
      end
    end
    
    # Approximates static typing for arguments
    def arg_kind_of(klass,object)
      if object.class != klass
        raise ArgumentError.new("Argument class mismatch for #{object.to_s}.")
      end
    end
    
  end
  
    #  ** INSTANCE METHODS **  #

  # Returns the airport object for the departure airport on this route
  def dep_airport
    Airport.get(self.dep_airport_code)
  end
  
  # Returns the airport object for the arrival airport on this route
  def arr_airport
    Airport.get(self.arr_airport_code)
  end
  
  
end
