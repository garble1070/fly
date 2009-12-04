# A currency, i.e. FLC (Fly Credits) or USD
class Currency < ActiveRecord::Base
  
  # TODO create methods to access accounts
  
  class << self
    def get(code)
      #TODO check for a string
      find(:first, :conditions => "code = '#{code}'")
    end
  end
  
end
