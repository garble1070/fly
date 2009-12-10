class Terminal < ActiveRecord::Base
  belongs_to :airline
  belongs_to :airport, 
    :foreign_key => "airport_code", 
    :primary_key => "code"

  named_scope :owned_by_airline, lambda { |airline_id|
    {:conditions => { "airline_id" => airline_id}}}
  

  
end
