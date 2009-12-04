# A route that our airplanes are allowed to fly, with mileage. Includes the
# option to specify a route for all aircraft types or one at a time
class Route < ActiveRecord::Base
  
      named_scope :citypair_is, lambda { |dep_id,arr_id| 
         {:conditions => { "dep_airport_id" => dep_id,
                           "arr_airport_id" => arr_id}}}

      named_scope :aircrafttype_is, lambda { |type_id|
          {:conditions => { "aircrafttype_id" => type_id}}}
  
  class << self
    
    #**********************************************#
    #              CLASS ATTRIBUTES                #
    #**********************************************#
    
    # Returns the route obj based on 2 airport objects and an aircrafttype object
    def identify(dep_airport,arr_airport,aircrafttype)
      if aircrafttype.class != Aircrafttype
        raise "Arguments do not include a valid aircrafttype"
      end
      if (dep_airport.class != Airport) || (arr_airport.class != Airport)
        raise "Arguments do not include 2 valid airport objects"
      end
      aircrafttype_id = aircrafttype.id
      routes = Route.citypair_is(dep_airport.id,arr_airport.id)
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
    
  end
  
  
  # Returns the airport object for the departure airport on this route
  def dep_airport
    Airport.find(dep_airport_id)
  end
  
  # Returns the airport object for the arrival airport on this route
  def arr_airport
    Airport.find(arr_airport_id)
  end
  
end
