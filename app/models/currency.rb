# A currency, i.e. FLC (Fly Credits) or USD
class Currency < ActiveRecord::Base
  has_many :accounts, :foreign_key => "currency_code", :primary_key => "code"
  
  named_scope :code_is , lambda{|code| { :conditions => {:code => code}
    }}
  
  #**********************************************#
  #            CLASS INSTANCE METHODS            #
  #**********************************************#

  class << self
    
    # Try to find an object using the code; if not, pass on to ActiveRecord::Base
    def method_missing(name, *args)
      item = get_item_from_code(name)
      if item
        item
      else
        super(name,*args)
      end
    end
    
    # Retrieve the object using the code. 
    def get_item_from_code(symbol)
      results = self.code_is(symbol.to_s)
      results.first
    end
    
  end
  
  #**********************************************#
  #               INSTANCE METHODS               #
  #**********************************************#
  
  
end
