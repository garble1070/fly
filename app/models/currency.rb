# A currency, i.e. FLC (Fly Credits) or USD
class Currency < ActiveRecord::Base
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Returns a currency object based on its code (passed as a string by argument)
    def get(code)
      find(:first, :conditions => "code = '#{code}'")
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  # Returns an array of accounts that are denominated in this currency
  def accounts
    Account.currency_is(self.code)
  end
  
end
