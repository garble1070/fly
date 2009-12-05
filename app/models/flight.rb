# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  belongs_to :plane
  belongs_to :route
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns this flight's plane object
  def plane_obj
    self.plane
  end
  
  # Returns this flight's route object
  def route_obj
    self.route
  end
  
end
