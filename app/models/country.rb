# A country where airports are located and airlines are headquartered
class Country < ActiveRecord::Base
  
    has_many :airports, :foreign_key => "country_code", :primary_key => "code"
    has_many :airlines, :foreign_key => "country_code", :primary_key => "code"

    named_scope :code_is , lambda{|code| { :conditions => {:code => code}
    }}

  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#

  class << self
 
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#

end
