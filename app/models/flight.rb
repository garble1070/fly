# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  belongs_to :plane
  
  belongs_to :dep_airport, 
      :class_name => "Airport", 
      :primary_key => "code",
      :foreign_key => "dep_airport_code"
  
  belongs_to :arr_airport, 
      :class_name => "Airport", 
      :primary_key => "code",
      :foreign_key => "arr_airport_code"

  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
 

  
end
