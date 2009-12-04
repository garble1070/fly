# Airport that accepts passenger traffic in our system
class Airport < ActiveRecord::Base
  # TODO create methods to access countries
  
  class << self
    def get(code)
      #TODO check for a string
      find(:first, :conditions => "code = '#{code}'")
    end
  end
  
end
