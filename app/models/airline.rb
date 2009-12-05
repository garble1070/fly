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
    Country.get(self.country_code)
  end

  # Creats a new Plane object, saves it to the database. Returns the object if save is successful.
  def acquire_plane(aircrafttype,airport,params={})
    arg_kind_of(Aircrafttype,aircrafttype)
    arg_kind_of(Airport,airport)
    arg_kind_of(Hash,params)
    
    @new_plane = Plane.new
    @new_plane.airline_id = need(id)
    @new_plane.aircrafttype_id = need(aircrafttype.id)
    @new_plane.starting_airport_code = need(airport.code)
    
    @new_plane.avg_pax_load = aircrafttype.avg_pax_load_default
    @new_plane.avg_speed = aircrafttype.avg_speed_default
    @new_plane.range = aircrafttype.range_default 

    params.each do |key,value|
      if @new_plane.attributes.has_key?(key.to_s)
        @new_plane.send("#{key.to_s}=",value)
      end
    end
    
    if @new_plane.save
      @new_plane
    else
      nil
    end
  end
  
  
end
