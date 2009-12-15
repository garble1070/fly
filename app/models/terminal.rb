class Terminal < ActiveRecord::Base
  belongs_to :airline
  belongs_to :airport, 
    :foreign_key => "airport_code", 
    :primary_key => "code"  

  
end
