# A country where airports are located and airlines are headquartered
class Country < ActiveRecord::Base
  # TODO create methods to access airports and airlines
  
  class << self
    def get(code)
      #TODO check for a string
      find(:first, :conditions => "code = '#{code}'")
    end
  end
  
end
