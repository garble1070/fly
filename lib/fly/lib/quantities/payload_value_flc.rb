# A class that allows the user to manage payload value easily
class PayloadValueFlc < Quantity
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # 
    def new_by_flight_creator_object(fc_object)
      instance = PayloadValueFlc.new
      dep_airport = fc_object.param_by_classname("DepartureAirport")
      arr_airport = fc_object.param_by_classname("ArrivalAirport")
      pax_count = fc_object.param_by_classname("Plane").avg_pax_count
      distance_miles = dep_airport.distance_from(arr_airport)
      instance.set_payload_value_by_distance_and_pax_count(distance_miles,pax_count)
      return instance
    end
  end
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#  
  
  # Returns the value from '@quantity'
  def payload_value_flc
    @quantity
  end
  
  # Sets the value for '@quantity'
  def payload_value_flc=(input)
    @quantity=input
  end
  
  def set_payload_value_by_distance_and_pax_count(distance_miles,pax_count)
    @quantity = 0
    self.increase(BASE_REVENUE_PER_FLIGHT_SEGMENT_FLC.to_f.round(2))
    self.increase((BASE_REVENUE_PER_PAX_FLOWN_FLC * pax_count).to_f.round(2))
    self.increase((REVENUE_PER_PAX_MILE_FLOWN_FLC * pax_count * distance_miles).to_f.round(2))
  end
end

