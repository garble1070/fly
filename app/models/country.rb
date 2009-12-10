# A country where airports are located and airlines are headquartered
class Country < ActiveRecord::Base
  
    has_many :airports, :foreign_key => "country_code", :primary_key => "code"
    has_many :airlines, :foreign_key => "country_code", :primary_key => "code"

  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self

    # Returns a country object based on its code (passed as a string by argument)
    def find(*args)
      if args[0].is_a?(String)
        find(:first, :conditions => "code = '#{args[0]}'")
      else
        super(*args)
      end
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#

end
