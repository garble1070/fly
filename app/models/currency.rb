# A currency, i.e. FLC (Fly Credits) or USD
class Currency < ActiveRecord::Base
  has_many :accounts, :foreign_key => "currency_code", :primary_key => "code"
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#
  
  class << self
    
    # Returns a currency object based on its code (passed as a string by argument)
    def find(*args)
      if args.first.is_a?(String)
        find(:first, :conditions => "code = '#{args.first}'")
      else
        super(*args)
      end
    end
  end
  
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  
end
