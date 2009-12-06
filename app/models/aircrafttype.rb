# Each particular aircraft model that is available in our ecosystem
class Aircrafttype < ActiveRecord::Base
  # DO NOT USE 'has_many :routes'  -- IT WILL BREAK STUFF
  has_many :planes
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
end
