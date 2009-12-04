# Each particular aircraft model that is available in our ecosystem
class Aircrafttype < ActiveRecord::Base
  has_many :routes
end
