# Each particular aircraft model that is available in our ecosystem
class Aircrafttype < ActiveRecord::Base
  #  has_many :routes   *** DO NOT UNCOMMENT THIS .. WILL BREAK STUFF
  has_many :planes
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
end
