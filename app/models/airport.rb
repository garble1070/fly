# Airport that accepts passenger traffic in our system
class Airport < ActiveRecord::Base
  

   acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng


  named_scope :country_is, lambda { |country_code|
    {:conditions => { "country_code" => country_code}}}
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Returns an airport object based on its code (passed as a string by argument)
    def find(*args)
      if args[0].is_a?(String)
        find(:first, :conditions => "code = '#{args[0]}'")
      else
        super(*args)
      end
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  #Returns this airport's country object
  def country_obj
    Country.find(self.country_code)
  end

  # Alias for 'country_obj', to match rails convention
  def country
    self.country_obj
  end
    
  # Returns an array representing lat/lng coordinates
  def geo_coords
    [self.lat,self.lng]
  end
  
end

