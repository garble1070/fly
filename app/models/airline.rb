# An airline, can be only owned by one user at a time.
class Airline < ActiveRecord::Base
  belongs_to :user
  has_many :planes

  named_scope :country_is, lambda { |country_code|
    {:conditions => { "country_code" => country_code}}}
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  #Returns this airline's country object
  def country
    Country.find(self.country_code)
  end

  # Creats a new Plane object, saves it to the database. Returns the object if save is 
  # successful.
  def acquire_new_plane(param_array)
    param_array << self
    new_plane = PlaneCreator.new(param_array).manufacture
    return new_plane.save ? new_plane : nil
  end
  
  
end
