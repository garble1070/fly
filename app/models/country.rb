# A country where airports are located and airlines are headquartered
class Country < ActiveRecord::Base
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self

    # Returns a country object based on its code (passed as a string by argument)
    def get(code)
      find(:first, :conditions => "code = '#{code}'")
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns an array of airlines that are associated with this country
  def airlines
    Airline.country_is(self.code)
  end
  
  # Returns an array of airports that are associated with this country
  def airports
    Airport.country_is(self.code)
  end
end
