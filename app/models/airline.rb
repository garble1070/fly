# An airline, can be only owned by one user at a time.
class Airline < ActiveRecord::Base
  belongs_to :user
  belongs_to :country, :foreign_key => "country_code"
  has_many :planes
  has_many :terminals
  has_many :flights, :through => :planes

  named_scope :country_is, lambda { |country_code|
    {:conditions => { "country_code" => country_code}}}
  
  named_scope :ops_airport_is, lambda{|airport| {
    :select=>"`airlines`.*",
    :joins=>"INNER JOIN `terminals` on `airlines`.id = `terminals`.airline_id",
    :conditions=>["`terminals`.airport_code = ?", airport.code]
  }}

  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Creats a new Plane object, saves it to the database. Returns the object if save is 
  # successful.
  def acquire_new_plane(param_array)
    param_array << self
    new_plane = PlaneCreator.new(param_array).manufacture
    return new_plane.save ? new_plane : nil
  end
  
  def ops_airports
     Airport.ops_airline_is(self)
  end
end
