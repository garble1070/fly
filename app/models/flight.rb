# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  belongs_to :plane
  belongs_to :route
  
end
