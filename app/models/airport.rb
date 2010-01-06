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
  
  belongs_to :country, 
      :foreign_key => "country_code", 
      :primary_key => "code"
  
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
  
  named_scope :code_is , lambda{|code| { :conditions => {:code => code}
    }}
  
  validates_presence_of     :code
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
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
  
  # Return a Geokit::LatLng object representing the location of this airport
  def latlng
    Geokit::LatLng.new(self.lat,self.lng)
  end
  
  
  
end
