# An airline, can be only owned by one user at a time.
class Airline < ActiveRecord::Base
  belongs_to :user
  # TODO create methods to access countries
  
  # Creats a new Plane object, saves it to the database. Returns the object if save is successful.
  def acquire_plane(aircrafttype,airport,params={})
    arg_kind_of(Aircrafttype,aircrafttype)
    arg_kind_of(Airport,airport)
    arg_kind_of(Hash,params)
    
    @new_plane = Plane.new
    @new_plane.airline_id = need(id)
    @new_plane.aircrafttype_id = need(aircrafttype.id)
    @new_plane.starting_airport_code = need(airport.code)
    
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
  
  # Returns a target object or raises an exception if nil
  def need(target)
    if target
      target
    else
      raise RuntimeError.new("Expecting object to be not nil.")
    end
  end
  
  # Approximates static typing for arguments
  def arg_kind_of(klass,object)
    if object.class != klass
      raise ArgumentError.new("Argument class mismatch for #{object.to_s}.")
    end
  end
  
end
