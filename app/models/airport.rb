# Airport that accepts passenger traffic in our system
class Airport < ActiveRecord::Base
  
  has_many :users_based_here_in_real_life, 
      :class_name => "User", 
      :foreign_key => "home_airport_code_real",
      :primary_key => "code"
  
  has_many :airlines_based_here_in_game, 
      :class_name => "Airline", 
      :foreign_key => "home_airport_code_game",
      :primary_key => "code"
  
  belongs_to :country, :foreign_key => "country_code"
  
  has_many :terminals, 
     :foreign_key => "airport_code", 
     :primary_key => "code"
  
  acts_as_mappable :default_units => :miles, 
                   :default_formula => :sphere, 
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng
  
  named_scope :ops_airline_is, lambda{|airline| {
    :select=>"`airports`.*",
    :joins=>"INNER JOIN `terminals` on `airports`.code = `terminals`.airport_code",
    :conditions=>["`terminals`.airline_id = ?", airline.id]
    }}
  
  named_scope :ops_user_is, lambda{|user| {
    :select=>"`airports`.*",
    :joins=>"INNER JOIN `terminals` on `airports`.code = `terminals`.airport_code 
             INNER JOIN `airlines` ON `terminals`.airline_id = `airlines`.id",
    :conditions=>["`airlines`.user_id = ?", user.id]
    }}
  
  
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
    
    # Executes a find if the method name is three letters long
    def method_missing(name, *args)
      if (name.is_a?(Symbol)) && (name.to_s.length == 3)
        Airport.find(name.to_s)
      end
    end
    
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns an array representing rounded lat/lng coordinates
  def to_s_rnd
    self.lat.to_s_rnd + "," + self.lng.to_s_rnd
  end
  
  # Returns an array representing lat/lng coordinates
  def to_s
    self.lat.to_s + "," + self.lng.to_s
  end
  
  # Returns an array representing airlines that have terminals at the current airport
  def ops_airlines
    Airline.ops_airport_is(self)
  end
  
  
end
