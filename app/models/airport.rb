# Airport that accepts passenger traffic in our system
class Airport < ActiveRecord::Base
  
  named_scope :country_is, lambda { |country_code|
    {:conditions => { "country_code" => country_code}}}
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Returns an airport object based on its code (passed as a string by argument)
    def get(code)
      find(:first, :conditions => "code = '#{code}'")
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  #Returns this airport's country object
  def country_obj
    Country.get(self.country_code)
  end

  # Alias for 'country_obj', to match rails convention
  def country
    self.country_obj
  end
  
  # Returns an array of routes that feature this airport as the departure city
  def routes_by_dep_city
    Route.dep_airport_is(self.code)
  end
  
  # Returns an array of routes that feature this airport as the arival city
  def routes_by_arr_city
    Route.arr_airport_is(self.code)    
  end
  
  # Returns an array of routes that feature this airport as either the departure 
  # or the arrival city
  def routes_all
    routes_by_dep_city + routes_by_arr_city
  end
  
end
