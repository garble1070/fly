# A particular plane flying a particular route at a particular time
class Flight < ActiveRecord::Base
  serialize :routing 
  
  belongs_to :plane
  
  belongs_to :dep_airport, 
      :class_name => "Airport", 
      :primary_key => "code",
      :foreign_key => "dep_airport_code"
  
  belongs_to :arr_airport, 
      :class_name => "Airport", 
      :primary_key => "code",
      :foreign_key => "arr_airport_code"
      
   named_scope :user_is, lambda{|user| {
    :select=>"`flights`.*",
    :joins=>"INNER JOIN `planes` on `planes`.id = `flights`.plane_id 
             INNER JOIN `airlines` ON `planes`.airline_id = `airlines`.id",
    :conditions=>["`airlines`.user_id = ?", user.id]
   }}
   
     named_scope :ops_airport_is, lambda{|airport| {
    :select=>"`airlines`.*",
    :joins=>"INNER JOIN `terminals` on `airlines`.id = `terminals`.airline_id",
    :conditions=>["`terminals`.airport_code = ?", airport.code]
  }}


  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
 
 def time_since_boarding_start
   (Time.new - boarding_started).to_int
 end

 def time_since_taxi_start
   (Time.new - taxi_started).to_int
 end
  
end
